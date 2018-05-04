class NewspapersController < ApplicationController
    before_action :set_newspaper ,only: [:edit, :update, :show, :destroy]
    def index
    end
  
    def new
    end
  
    def create
    end 
  
    def edit
    end
  
    def update
    end
  
    def show
    end
  
    def destroy
    end
  
    def set_newspaper
      @newspaper = Newspaper.find(params[:id])
    end
  
    private
    def newspaper_params
      params.require(:newspaper).permit(:title, :text)
    end
end
