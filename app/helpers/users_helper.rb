module UsersHelper
  def admin_only
    if current_user.present?
      current_user.role == "admin"
    end
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.last_name, class: "gravatar")
  end

  def comment_count(user)
    Comment.where(user_id: user.id).count
  end

  def newspaper_count(user)
    Newspaper.where(user_id: user.id).count
  end
end
