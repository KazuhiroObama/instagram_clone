class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:create, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @pictures = @user.pictures
    @favorite = @user.favorites
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録後、current_userをnilにしておきたくない。
      # 「@user.id == current_user.id」でエラーになる。
      session[:user_id] = @user.id
      flash["alert-success"] = '新規ユーザー登録完了しました'
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if params[:user].nil?
      flash["alert-danger"] = 'プロフィール画像を選択して下さい'
      redirect_back(fallback_location: root_path)
    else
      if @user.update(user_params)
        flash["alert-info"] = 'プロフィールを変更しました'
        redirect_back(fallback_location: root_path)
      else
        flash["alert-danger"] = 'プロフィールを変更失敗しました'
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    if @user.destroy
      flash["alert-danger"] = '投稿した画像を含め、ユーザー情報を全て削除しました'
      redirect_to root_url
    else
      flash["alert-danger"] = 'ユーザー情報の削除に失敗しました'
      redirect_to edit_user_path(@user.id)
    end
  end

  private
    def set_user
      # rootメソッド使用時、current_user.idを使用
      @user = User.find_by(id: params[:id]) || User.find_by(id: current_user.id)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_digest, :icon, :remove_icon)
    end
end
