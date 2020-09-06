class MemosController < ApplicationController
  before_action :set_login

  def index
    @memos = Memo.all.where(user_id:current_user.id).order(updated_at:"DESC")
    @memos = Kaminari.paginate_array(@memos).page(params[:page]).per(20)
  end
  
  def new
    @memo=Memo.new
    @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
  end

  def create
    @memo=Memo.new(memo_params)
    if @memo.save
      redirect_to memo_path(@memo)
    else
      @memo=Memo.new(memo_params)
      @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
      render :new
    end
  end

  def show
    @memo = Memo.find(params[:id])
    @favorite = current_user.favorites.find_by(memo_id: @memo.id)
    @posts =  @memo.posts.map
    redirect_to root_path unless @memo.user_id ==current_user.id
  end

  def destroy
    @memo=Memo.find(params[:id])
    @memo.destroy
    @memos = Memo.all.where(user_id:current_user.id).order(updated_at:"DESC")
    @memos = Kaminari.paginate_array(@memos).page(params[:page]).per(20)
    redirect_to memos_path
  end

  def edit
    @memo = Memo.find(params[:id])
    @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
    redirect_to root_path unless @memo.user_id ==current_user.id
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      @memo = Memo.find(params[:id])
      @posts =  @memo.posts.map.sort.reverse
      redirect_to memo_path
    else
      @memo = Memo.find(params[:id])
      @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
      render :edit
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
