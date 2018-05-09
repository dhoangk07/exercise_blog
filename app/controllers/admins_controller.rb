# class AdminsController < ApplicationController
#     before_action :set_admin ,only: [:edit, :update, :show, :destroy]
#     def index
#       @users = User.all
#       @newspapers = Newspaper.all
#     end
  
#     def new
#       @user = User.new
#       @newspapers = Newspaper.new
#     end
  
#     def create
#       @user = User.new(user_params)
#     end 
  
#     def edit
#     end
  
#     def update
#     end
  
#     def show
#     end
  
#     def destroy
#     end
  
#     def set_admin
#       @admin = admin.find(params[:id])
#     end
  
#     private
#     def user_params
#       params.require(:admin).permit(:title, :text)
#     end
# end