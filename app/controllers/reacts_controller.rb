class ReactsController < ApplicationController
  before_action :find_reactable

  def update
    flash[:notice] = if @react.update(reaction: params[:reaction])
                       'Changed reaction successfully!'
                     else
                       'Unable to change react!'
                     end
  end

  def already_reacted?
    unless @reactable.reacts.find_by(user_id: current_user.id).nil?
      @react = @reactable.reacts.find_by(user_id: current_user.id)
      if @react.reaction == params[:reaction]
        destroy
      else
        update
      end
    end
  end

  def create
    unless already_reacted?
      @react = @reactable.reacts.new(reaction: params[:reaction], user_id: current_user.id)
      @react.save
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    @react.delete
    flash[:notice] = 'Removed reaction successfully!'
  end

  protected

  def find_reactable
    @reactable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @reactable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
