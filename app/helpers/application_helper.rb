module ApplicationHelper
  def ensure_correct_user
    if @user != current_user
      flash["alert-danger"] = "権限がありません"
      redirect_to @user
    end
  end

  def picture_correct_user
    if @picture.user != current_user
      flash["alert-danger"] = "権限がありません"
      redirect_to @user
    end
  end
end
