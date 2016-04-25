class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://giftswap.herokuapp.com/'
    mail(to: @user.email, subject: "Welcome to GiftSwap.com")
  end

  def new_group_email(user, group)
    @user = user
    @group = group
    @url = 'https://giftswap.herokuapp.com/'
    mail(to: @user.email, subject: "You created a new group on GiftSwap.com")
  end

  def invitation_email(email, group)
    @group = group
    @url = 'https://giftswap.herokuapp.com/'
    mail(to: email, subject: "#{group.admin.first_name} wants you to join a GiftSwap.com")
  end

  def match_email(group, giver, receiver)
    @group = group
    @giver = giver
    @receiver = receiver
    @url = 'https://giftswap.herokuapp.com/'
    mail(to: giver.email, subject: "You're giving a gift to #{receiver.full_name} in #{group.name}")
  end
end
