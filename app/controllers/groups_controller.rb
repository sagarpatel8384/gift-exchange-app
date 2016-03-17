class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin_membership(current_user)

    if @group.save
      UserMailer.new_group_email(current_user, @group).deliver_now
      create_group_invitations
      redirect_to @group
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :exchange_date, :max_price)
  end

  def create_group_invitations
    invites_array = params[:invitations].gsub(" ", "").split(",")
    invites_array.uniq.each { |email| UserMailer.invitation_email(email, @group).deliver_now}
    invites_array.each { |email| @group.invitations.create(email: email) }
  end
end
