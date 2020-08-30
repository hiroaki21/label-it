class MemosController < ApplicationController

  def new
    @memo=Memo.new
    @posts=Post.search(params[:keyword],current_user.id).order(id: "DESC")
  end

  def create
    @memo=Memo.new(memo_params)
    if @memo.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def memo_params
    params.require(:memo).permit(:title,:desc,{:post_ids => []}).merge(user_id: current_user.id)
  end
end
