class UsersController < ApplicationController
  def create_follow
    @followed_user = FollowedUser.new(user_id: current_user.id, followed_user_id: params[:user_id])
    flash[:notice] = if @followed_user.save
                       'Successfully Followed'
                     else
                       "Couldn't Follow"
                     end
    redirect
  end

  def destroy_follow
    @followed_user = FollowedUser.find_by(user_id: current_user.id, followed_user_id: params[:user_id])
    @followed_user.destroy
    redirect
  end

  def redirect
    redirect_back fallback_location: root_path
  end
end
