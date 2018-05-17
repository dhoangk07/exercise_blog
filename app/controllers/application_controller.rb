class ApplicationController < ActionController::Base
  def authorize
    if current_user.nil?
      redirect_to edit_user_registration_path, alert: "Not authorized! Please log in"
    else
      if @newspaper && @newspaper.user != current_user
        redirect_to root_path, alert: "Not authorized! Only #{@newspaper.user} only access to this news paper"
      end
    end
  end
end
