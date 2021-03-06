class User < ApplicationRecord
  extend Enumerize
  enumerize :role, in: [:admin, :user], default: :user

  # Rails Enum
  # enum status: { active: 0, archived: 1 }
  acts_as_voter
  has_many :hides, dependent: :destroy
  has_many :unlikes, dependent: :destroy
  has_many :reacts, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def reacted?(newspaper)
    React.where(user_id: id, newspaper_id: newspaper.id).present?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name

      # parse_name(user, auth.info.name)

      # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  validates :first_name, presence: true, unless: -> { from_facebook? }

  validates :last_name, presence: true, unless: -> { from_facebook? }

  validates  :password, :presence   => true,
            :confirmation           => true,
            :length                 => {:within => 6..40}, :on => :create

  has_many :newspapers, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#", small: "70x70#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def split_name(name)
    first_name = name.split(" ").first_name

    last_name = name.split(" ").drop(1).join(" ")
  end

  def self.search(search)
    if search
       self.where('email LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      self
    end
  end

  def avatar_url_user
    Faker::Avatar.image
  end

  def full_name
    if first_name && last_name
    "#{first_name} #{last_name}"
    elsif name
      name
    else
      email
    end
  end

  def from_facebook?
    provider == 'facebook'
  end

  def self.search(search)
    if search
      self.where('last_name ILIKE ? OR first_name ILIKE ?', "%#{search}%", "%#{search}%")
    else
      self
    end
  end
  # private
  #   def self.parse_name(user, name)
  #     name_arr = name.split(“ “)
  #     user.last_name = name_arr.pop
  #     user.first_name = name_arr.join(“ “)
  #   end
end
