class NewspapersController < ApplicationController
  before_action :set_newspaper ,only: %i[edit update show destroy vote unlike hide display private_post public_post react ]
  before_action :authorize, except: %i[show index nil vote unlike react]
  def index
    @newspaper = Newspaper.new
    @tags = Tag.all
    @taggings = Tagging.all
    @newspapers = Newspaper.order("created_at DESC").where(published: false)

    @newspapers = if params[:tag]
    @newspapers = @newspapers.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter].present?
      @newspapers = current_user.newspapers.where(published: false).paginate(:page => params[:page], :per_page => 3)
    elsif params[:filter_tag].present?
      if @tagging.present?
        newspaper_id = Tagging.find_by(id: params[:filter_tag]).newspaper_id
        @newspapers = @newspapers.where(id: newspaper_id).paginate(:page => params[:page], :per_page => 3)
      else
        redirect_to nil_path
      end
    elsif params[:current_user].present?
    elsif params[:order] == "oldest"
      @newspaper = @newspapers.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "newest"
      @newspaper = @newspapers.order("created_at ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "alphabet"
      @newspaper = @newspapers.order("title ASC").paginate(:page => params[:page], :per_page => 3)
    elsif params[:order] == "like"
      @newspaper = @newspapers.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    else
      @newspapers = @newspapers.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
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
    @newspapers = Newspaper.search(params[:search]).where(published: false).paginate(:page => params[:page], :per_page => 3)
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

  # def hidden
  #   @hidden_newspapers = Hide.where(user_id: current_user)
  #   @newspaper_id = @hidden_newspapers.pluck(:newspaper_id)
  #   @newspapers = Newspaper.where(id: @newspaper_id).paginate(:page => params[:page], :per_page => 3)
  # end

  # def display
  #   Hide.where(:user_id =>current_user, :newspaper_id => params[:id]).destroy_all
  #   redirect_to hidden_newspapers_path
  # end

  def private_post
    @newspapers = @newspaper.update(published: true)
    # redirect_to private_zone_newspapers_path
    # if params[:filter] == "current_user"
      redirect_to newspapers_path(filter: current_user)
    # else 
    #   redirect_to newspapers_path
    # end
    redirect_to request.referrer
  end

  def private_zone
    @newspaper = Newspaper.where(published: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    @newspapers = @newspaper.all
  end

  def public_post
    if @newspapers = @newspaper.update(published: false)
      redirect_to private_zone_newspapers_path
    end
  end

  def react
    if reacted?(current_user, @newspaper)
      unreacted_by(current_user, @newspaper)
    else 
      reacted_by(current_user, @newspaper, params[:reaction])
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def set_newspaper
      @newspaper = Newspaper.find(params[:id])
    end

    def newspaper_params
      params.require(:newspaper).permit(:title, :content, :search, :tag_list, :image, :reaction)
    end
end
