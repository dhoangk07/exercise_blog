class React < ApplicationRecord
  belongs_to :user
  belongs_to :newspaper
  validates_uniqueness_of :user_id, scope: :newspaper_id
end
