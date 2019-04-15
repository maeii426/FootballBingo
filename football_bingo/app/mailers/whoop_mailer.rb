class WhoopMailer < ApplicationMailer
  default from: "admin@whoop.com"

  def send_email(user)
    @user=user
    logger.info @user.email

    mail(to: @user.email, subject: 'Collect Your Whoop Prize!')
  end
end
