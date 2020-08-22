class PostsController < ApplicationController

  def index
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params) 
    render json:{post:post} 
  end

  private

  def post_params
    params.require(:post).permit(:body).merge(user_id: current_user.id)
  end
end
