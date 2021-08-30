class UsersController < ApplicationController

  def create_follow
    @followed_user = FollowedUser.new(user_id: current_user.id, followed_user_id: params[:user_id])
    if @followed_user.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, notice: "Couldn't Follow"
    end
  end
end
