class IconsController < ApplicationController
  before_action :user_icon_identify

  def create
    @icon = Icon.new(icon_params)
    if @icon.save
      flash["alert-success"] = "プロフィール画像を登録しました"
      redirect_back(fallback_location: root_path)
    else
      flash["alert-danger"] = "プロフィール画像登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  def destroy
    Icon.find(params[:id]).delete
    flash["alert-info"] = 'プロフィール画像を削除しました'
    redirect_back(fallback_location: root_path)
  end
  def update
    @icon = Icon.find(params[:id])
    if @icon.update(icon_params)
      flash["alert-success"] = 'プロフィール画像を更新しました'
      redirect_back(fallback_location: root_path)
    else
      flash["alert-danger"] = "プロフィール画像更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  private
    def icon_params
      params.require(:icon).permit(:thumbnail, :user_id)
    end
    def user_icon_identify
      if params[:icon].present?
        @user = User.find(params[:icon][:user_id])
      else
        @user ||= Icon.find(params[:id]).user
      end
      if @user != current_user
        flash["alert-danger"] = "権限がありません"
        redirect_to @user
      end
    end
end
