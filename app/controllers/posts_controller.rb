class PostsController < ApplicationController
  before_action :set_login, only: [:new, :create]
  def index
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params) 
    render json:{post:post} 
  end

  def search
  end

  private

  def set_login
    unless user_signed_in?
      redirect_to '/login'
    end
  end

  def post_params
    params.require(:post).permit(:body).merge(user_id: current_user.id)
  end
end
