class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://gif-club.tumblr.com/'
    mail(to: @user.email, subject: "Welcome to Gift Club")
    
  end

  def new_group_email(user, group)
    @user = user
    @group = group
    @url = 'http://gif-club.tumblr.com/'
    mail(to: @user.email, subject: "You created a new group on Gift Exchange")
  end

  def invitation_email(user, group)
    @user = user
    @group = group
    @url = 'http://gif-club.tumblr.com/'
    mail(to: @user.email, subject: "#{group.admin.first_name} wants you to join a Gift Exchange")
  end
end
