class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: [:edit, :update, :show, :destroy]
  before_action :authorize, except: [:show, :index, :nil]
  def index
    @newspaper = Newspaper.new
    @tags = Tag.all
    @taggings = Tagging.all
    @newspapers = if params[:tag]
    @newspapers = Newspaper.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter].present?
      @newspapers = User.find(params[:filter]).newspapers.paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter_tag].present?
      if @tagging.present?
        newspaper_id = Tagging.find_by(id: params[:filter_tag]).newspaper_id
        @newspapers = Newspaper.where(id: newspaper_id).paginate(:page => params[:page], :per_page => 3)
      else
        redirect_to nil_path
      end
    elsif params[:order] == "oldest"
      @newspaper = Newspaper.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "newest"
      @newspaper = Newspaper.order("created_at ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "alphabet"
      @newspaper = Newspaper.order("title ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "like"
      @newspaper = Newspaper.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    else
      @newspapers = Newspaper.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
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
      respond_to do |format|
        format.html { redirect_to @newspaper }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "new" }
        format.js
      end
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

  def nil

  end

  def set_newspaper
    @newspaper = Newspaper.find(params[:id])
  end

  private
  def newspaper_params
    params.require(:newspaper).permit(:title, :content, :search, :tag_list, :image)
  end
end
