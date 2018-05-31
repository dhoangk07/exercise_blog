class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      # first_name = @user.name.split(" ").first
      # last_name = @user.name.split(" ").drop(1).join(" ")
      # User.update(first_name: first_name, last_name: last_name)
      sign_in_and_redirect @user, :event => :authentication

      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
