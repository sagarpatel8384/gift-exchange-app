class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://lit-atoll-85487.herokuapp.com/'
    mail(to: @user.email, subject: "Welcome to GIFTdotCOM.com")
  end

  def new_group_email(user, group)
    @user = user
    @group = group
    @url = 'https://lit-atoll-85487.herokuapp.com/'
    mail(to: @user.email, subject: "You created a new group on GIFTdotCOM.com")
  end

  def invitation_email(email, group)
    @group = group
    @url = 'https://lit-atoll-85487.herokuapp.com/'
    mail(to: email, subject: "#{group.admin.first_name} wants you to join a GIFTdotCOM.com")
  end

  def match_email(group, giver, receiver)
    @group = group
    @giver = giver
    @receiver = receiver
    @url = 'https://lit-atoll-85487.herokuapp.com/'
    mail(to: giver.email, subject: "You're giving a gift to #{receiver.full_name} in #{group.name}")
  end
end
