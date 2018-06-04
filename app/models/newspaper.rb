class Newspaper < ApplicationRecord
  acts_as_votable
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :taggings
  has_many :tags, through: :taggings
  has_many :hides, dependent: :destroy
  has_many :unlikes, dependent: :destroy
  has_many :reacts, dependent: :destroy

  def reacted_by(user, reaction)
    React.create(user_id: user.id, newspaper_id: id, reaction: reaction)
  end

  def unreacted_by(user)
    React.where(user_id: user.id, newspaper_id: id).destroy_all
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).newspapers
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#", small: "70x70#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.search(search)
    if search
      self.where('title ILIKE ? OR content ILIKE ?', "%#{search}%", "%#{search}%")
    else
      self
    end
  end

  def avatar_url_newspaper
    Faker::Avatar.image
  end
end
