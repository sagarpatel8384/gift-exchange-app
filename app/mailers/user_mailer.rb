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

  def match_email(group, giver, receiver)
    @group = group
    @giver = giver
    @receiver = receiver
    @url = 'http://gif-club.tumblr.com/'
    mail(to: giver.email, subject: "You're giving a gift to #{receiver.full_name} in #{group.name}")
  end
end
