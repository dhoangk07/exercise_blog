class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates  :email,     :presence   => true,
            :format                 => { with: VALID_EMAIL_REGEX },
            :uniqueness             => {:case_sensitive => false}

  validates  :password,  :presence   => true,
            :confirmation           => true,
            :length                 => {:within => 6..40}, :on => :create

  has_many :newspapers, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#", small: "70x70#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.search(search)
    if search
       self.where('email LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      self
    end
  end
end
