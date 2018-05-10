class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  def index
    if params[:filter] == "admin" 
      @users = User.where(role: params[:filter])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def destroy
    if @user.destroy
      redirect_to users_path
      flash[:danger] = "#{@user.first_name} #{@user.last_name} has been deleted "
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
