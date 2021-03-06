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

  def current_user_full_name
  #   # if current_user.first_name = nil || current_user.last_name == nil
  #   #   current_user.name
  #   # else
  #   split_name(current_user.name)
      current_user.first_name + " " + current_user.last_name
      # user.first_name + " " + user.last_name
  #   # end
  end
end
