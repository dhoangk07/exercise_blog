class Tag < ApplicationRecord
    has_many :taggings
    has_many :newspapers, through: :taggings
end
