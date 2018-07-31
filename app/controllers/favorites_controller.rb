class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    flash["alert-success"] = "#{favorite.picture.user.name}さんのブログをお気に入り登録しました"
    redirect_to picture_path(params[:picture_id])
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    flash["alert-danger"] = "#{favorite.picture.user.name}さんのブログをお気に入り解除しました"
    redirect_to picture_path(favorite.picture.id)
  end
end
