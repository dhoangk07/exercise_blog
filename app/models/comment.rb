class Comment < ApplicationRecord
  belongs_to :newspaper
  belongs_to :user
end
