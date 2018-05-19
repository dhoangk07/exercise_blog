class Tag < ApplicationRecord
    has_many :taggings, through: :taggings
    has_many :newspapers, through: :taggings
end
