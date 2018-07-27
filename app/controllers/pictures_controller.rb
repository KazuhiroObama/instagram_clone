class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    @pictures = Picture.all
    @favorite = current_user.favorites
  end

  def show
  end

  def new
    @picture = Picture.new
    @comment = @picture.comments.build
  end

  def edit
    @comment = @picture.comments.last
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      flash["alert-success"] = '写真投稿完了しました'
      redirect_to @picture
    else
      flash["alert-danger"] = '写真投稿に失敗しました'
      render :new
    end
  end

  def update
    if @picture.update_attributes(picture_params)
      flash["alert-success"] = '写真を更新しました'
      redirect_to @picture
    else
      flash.now["alert-danger"] = '写真の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @picture.destroy
      flash["alert-info"] = '写真を削除しました'
      redirect_to @user
    else
      flash.now["alert-danger"] = '写真の削除に失敗しました'
      render :edit
    end
  end

  def favorite
    @picture = current_user.favorite_pictures
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
      @user = @picture.user
    end

    def picture_params
      params.require(:picture).permit(:image, {comments_attributes: [:content]})
    end
end
