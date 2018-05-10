class Newspaper < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.search(search)
    if search
       self.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
    else
      self
     end
  end
end
