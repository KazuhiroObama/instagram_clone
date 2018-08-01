class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: @picture.email, subject: "写真投稿完了のお知らせ"
  end
end
