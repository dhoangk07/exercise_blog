class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :set_user, only: [:show, :destroy, :update]
  def index
    if params[:filter] == "admin" 
      @users = User.where(role: params[:filter]).paginate(:page => params[:page], :per_page => 5)
    elsif params[:filter] == "user" 
      @users = User.where(role: params[:filter]).paginate(:page => params[:page], :per_page => 5)
    else
      @users = User.paginate(:page => params[:page], :per_page => 5)
    end

    if params[:search].present?
      @users = @users.search(params[:search])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  def update
    if @user.update(user_params)
      redirect_to users_path
      flash[:success] = "#{@user.first_name} #{@user.last_name} has been uploaded successfully "
    else 
      render "edit"   
    end
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
