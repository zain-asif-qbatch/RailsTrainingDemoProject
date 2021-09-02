class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  # GET /posts or /posts.json
  # def index
  #   @posts = current_user.posts
  # end

  def newsfeed
    @followed_users = User.where(id: current_user.followed_users.pluck(:followed_user_id).push(current_user.id))
    @not_followed_users = User.where.not(id: current_user.followed_users.pluck(:followed_user_id).push(current_user.id))
  end

  def show
    @reacts = @post.reacts.reactions_counts
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit() end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: 'Your post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      redirect_back fallback_location: root_path, notice: 'Your post was successfully updated.' 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Your post was successfully destroyed.'
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end
end
