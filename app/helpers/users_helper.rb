module UsersHelper
  def admin_only
    if current_user.present?
      current_user.role == "admin"
    end
  end
end
