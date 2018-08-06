class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :picture_correct_user, only: [:update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    comment = @picture.comments.find_by(user_id: current_user.id)
    if comment.present?
      @comment = comment
    else
      @comment = Comment.new
    end
  end

  def new
    @picture = Picture.new
    @comment = @picture.comments.build
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    Comment.new.user_id = current_user.id

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
    if @picture.update(picture_params)
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
      redirect_to @picture.user
    else
      flash.now["alert-danger"] = '写真の削除に失敗しました'
      render :edit
    end
  end

  def favorite
    @pictures = current_user.favorite_pictures
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end
    def picture_params
      params.require(:picture).permit(:image, {comments_attributes: [:content, :id, :_destroy, :user_id]})
    end
end
