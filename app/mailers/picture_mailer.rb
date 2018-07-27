class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: "safetyadress2005-drivetraffic@yahoo.co.jp", subject: "写真投稿完了のお知らせ"
  end
end
