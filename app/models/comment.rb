class Comment < ApplicationRecord
  belongs_to :newspaper
  belongs_to :user

  scope :comment_count, -> user { where(user_id: user.id).count }
end
