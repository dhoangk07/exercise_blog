module ReactsHelper
  def reacted?(user, newspaper)
    React.where(user_id: user.id, newspaper_id: newspaper.id).present?
  end

  def reacted_by(user, newspaper, reaction)
    React.create(user_id: user.id, newspaper_id: newspaper.id, reaction: reaction)
  end

  def unreacted_by(user, newspaper)
    React.where(user_id: user.id, newspaper_id: newspaper.id).destroy_all
  end
end
