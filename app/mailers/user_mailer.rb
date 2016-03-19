class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://gif-club.tumblr.com/'
    mail(to: @user.email, subject: "Welcome to GIFTdotCOM.com")
  end

  def new_group_email(user, group)
    @user = user
    @group = group
    @url = 'http://gif-club.tumblr.com/'
    mail(to: @user.email, subject: "You created a new group on GIFTdotCOM.com")
  end

  def invitation_email(email, group)
    @group = group
    @url = 'http://gif-club.tumblr.com/'
    mail(to: email, subject: "#{group.admin.first_name} wants you to join a GIFTdotCOM.com")
  end
end
