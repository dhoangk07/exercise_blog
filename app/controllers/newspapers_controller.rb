class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: [:edit, :update, :show, :destroy]
  before_action :authorize, except: [:show, :index]
  def index
    @newspapers = Newspaper.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    if params[:search].present?
      @newspapers = @newspapers.search(params[:search])
    end
  end

  def new
    @newspaper = Newspaper.new
  end

  def create
    @newspaper = current_user.newspapers.create(newspaper_params)
    if @newspaper.save
      flash[:success] =  "Newspaper already created successful"
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
      flash[:success] =  "Newspaper already updated successful"
    else 
      render "edit"
    end
  end

  def show
  end

  def destroy
    if @newspaper.destroy
      redirect_to newspapers_path
      flash[:danger] = "Newspaper already destroy successful"
    end
  end

  def set_newspaper
    @newspaper = Newspaper.find(params[:id])
  end

  private
  def newspaper_params
    params.require(:newspaper).permit(:title, :content, :search)
  end
end
