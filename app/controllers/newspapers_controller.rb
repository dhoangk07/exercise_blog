class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: [:edit, :update, :show, :destroy]
  def index
    @newspapers = Newspaper.all
  end

  def new
    @newspaper = Newspaper.new
  end

  def create
    @newspaper = Newspaper.create(newspaper_params)
    if @newspaper.save
      redirect_to @newspaper
    else
      render "new"
    end
  end 

  def edit
  end

  def update
    if @newspaper.update(newspaper_params)
      redirect_to newspapers_path
    else 
      render "edit"
    end
  end

  def show
  end

  def destroy
    if @newspaper.destroy
      redirect_to newspapers_path
    end
  end

  def set_newspaper
    @newspaper = Newspaper.find(params[:id])
  end

  private
  def newspaper_params
    params.require(:newspaper).permit(:title, :content)
  end
end
