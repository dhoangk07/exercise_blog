class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: [:edit, :update, :show, :destroy, :vote, :unlike]
  before_action :authorize, except: [:show, :index, :nil, :vote, :unlike]
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
    elsif params[:current_user].present?
      @newspapers = current_user.newspapers
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
    session[:back_url] = request.referrer
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
  end

  def destroy
    session[:back_url] = request.referrer
    if @newspaper.destroy
      redirect_path = session.delete(:back_url) || newspapers_path
      redirect_to redirect_path 
      flash[:danger] = "Newspaper already destroy successful"
    end
  end

  def nil
  end

  def search
    @newspapers = Newspaper.search(params[:search]).paginate(:page => params[:page], :per_page => 3)
    respond_to do |format|
      format.js
      format.html { redirect_to @newspaper }
    end
  end

  def vote
    if !current_user.liked? @newspaper
      @newspaper.liked_by current_user
    else current_user.liked? @newspaper
      @newspaper.unliked_by current_user
    end
  end

  def unlike
    if !current_user.disliked? @newspaper
      @newspaper.disliked_by current_user
    else current_user.disliked? @newspaper
      @newspaper.liked_by current_user
    end
  end

  def hide
    @newspaper = Newspaper.find(params[:id])
    @hide = @newspaper.hides.create(user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  private
    def set_newspaper
      @newspaper = Newspaper.find(params[:id])
    end

    def newspaper_params
      params.require(:newspaper).permit(:title, :content, :search, :tag_list, :image)
    end
end
