class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(memo_id: params[:memo_id])
    redirect_to memo_path(favorite.memo.id)
    flash[:key] = "--お気に入りに登録しました--"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to memo_path(favorite.memo.id)
    flash[:key] = "--お気に入りを解除しました--"
  end
end
