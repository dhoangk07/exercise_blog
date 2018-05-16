class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :update, :edit]
  def index

    if params[:filter] == "admin" 
      @users = User.where(role: params[:filter]).paginate(:page => params[:page], :per_page => 5)
    elsif params[:filter] == "user" 
      @users = User.where(role: params[:filter]).order('created_at ASC').paginate(:page => params[:page], :per_page => 5)
    elsif params[:order] == "email" 
      @users = User.order("email DESC").paginate(:page => params[:page], :per_page => 5)
    elsif params[:order] == "sign_in" 
      @users = User.order("sign_in_count DESC").paginate(:page => params[:page], :per_page => 5)
    elsif params[:order] == "last_name" 
      @users = User.order("last_name ASC").paginate(:page => params[:page], :per_page => 5)
    elsif params[:order] == "first_name" 
      @users = User.order("first_name ASC").paginate(:page => params[:page], :per_page => 5)
      @first_name_order_direction = params[:direction]
    
    else
      @users = User.order('first_name ASC').paginate(:page => params[:page], :per_page => 5)
    end

    @users = User.order("#{params[:order]} ASC")

    if params[:search].present?
      @users = @users.search(params[:search])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    session[:back_url] = request.referrer
  end

  def update
    if @user.update(user_params)
      flash[:success] = "#{@user.first_name} #{@user.last_name} has been uploaded successfully "
      redirect_path = session.delete(:back_url) || users_path
      redirect_to redirect_path
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

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :image)
  end
end