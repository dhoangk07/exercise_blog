module ReactsHelper
  def reacted?(user, newspaper)
    React.where(user_id: user.id, newspaper_id: newspaper.id).present?
  end
end
