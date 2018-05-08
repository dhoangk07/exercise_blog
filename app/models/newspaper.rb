class Newspaper < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

end
