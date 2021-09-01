class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    flash[:notice] = if @comment.save
                       'Your comment was successfully posted!'
                     else
                       flash[:notice] = "Your comment wasn't posted!"
                     end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js   { }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comment_id = params[:id]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js   { }
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
