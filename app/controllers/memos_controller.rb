class MemosController < ApplicationController
  before_action :set_login, only: [:new, :create]

  def index
    @memos = Memo.all.where(user_id:current_user.id).order(id:"DESC")
    @memos = Kaminari.paginate_array(@memos).page(params[:page]).per(20)
  end
  
  def new
    @memo=Memo.new
    @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
  end

  def create
    @memo=Memo.new(memo_params)
    if @memo.save
      redirect_to root_path
    else
      @memo=Memo.new(memo_params)
      @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
      render :new
    end
  end

  private
  def set_login
    unless user_signed_in?
      redirect_to '/login'
    end
  end

  def memo_params
    params.require(:memo).permit(:title,:desc,{:post_ids => []}).merge(user_id: current_user.id)
  end
end
