class CommentsController < ApplicationController
  def create
    @newspaper = Newspaper.find(params[:newspaper_id])
    @comment = @newspaper.comments.create(comment_params)
    @comment.save
    redirect_to newspaper_path(@newspaper)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id)
    end
end
