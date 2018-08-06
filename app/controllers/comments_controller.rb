class CommentsController < ApplicationController
  before_action :set_picture
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @picture.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash["alert-success"] = 'コメントを投稿しました'
      redirect_to @picture
    else
      flash["alert-danger"] = 'コメントに失敗しました'
      redirect_to @picture
    end
  end

  def update
    @comment.user_id = current_user.id
    if @comment.update(comment_params)
      flash["alert-success"] = 'コメントを更新しました'
      redirect_to @picture
    else
      flash.now["alert-danger"] = 'コメントの更新に失敗しました'
      redirect_to @picture
    end
  end

  def destroy
    @comment.user_id = current_user.id
    if @comment.destroy
      flash["alert-info"] = 'コメントを削除しました'
      redirect_to @picture
    else
      flash.now["alert-danger"] = 'コメントの削除に失敗しました'
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def set_picture
    @picture = Picture.find(params[:picture_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
