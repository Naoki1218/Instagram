class PhotoMailer < ApplicationMailer
  def photo_mail(photo)
    @photo = photo
    mail to: @photo.user.email, subject: "#投稿されました!!"
  end
end
