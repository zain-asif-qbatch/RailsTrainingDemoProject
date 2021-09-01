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
    ActionCable.server.broadcast "reacts:all", { reactable: render(
      partial: 'reacts/reacts', locals: { reactable: @reactable }
    ), reactable_id: @reactable.id, reactable_type: @reactable.class.name }
  end

  def destroy
    @react.delete
    flash[:notice] = 'Removed reaction successfully!'
  end

  protected

  def find_reactable
    @reactable = Comment.find_by_id(params[:id]) if params[:type] == 'Comment'
    @reactable = Post.find_by_id(params[:id]) if params[:type] == 'Post'
  end
end
