class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: [:edit, :update, :show, :destroy]
  before_action :authorize, except: [:show, :index]
  def index
    @tags = Tag.all
    @newspapers = if params[:tag]
    @newspapers = Newspaper.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter].present?
      @newspapers = User.find(params[:filter]).newspapers.paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter_tag].present?
      newspaper_id = Tagging.all.find(params[:filter_tag]).newspaper_id
      @newspapers = Newspaper.where(id: newspaper_id).paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "oldest"
      @newspaper = Newspaper.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "newest"
      @newspaper = Newspaper.order("created_at ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "alphabet"
      @newspaper = Newspaper.order("title ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "like"
      @newspaper = Newspaper.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    else
      @newspapers = Newspaper.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
    end
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
      redirect_to newspaper_path(@newspaper)
      flash[:success] =  "Newspaper already updated successful"
    else 
      render "edit"
    end
  end

  def show
      @tags = Tag.all
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
    params.require(:newspaper).permit(:title, :content, :search, :tag_list)
  end
end
