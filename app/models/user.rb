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

  has_many :newspapers
end
