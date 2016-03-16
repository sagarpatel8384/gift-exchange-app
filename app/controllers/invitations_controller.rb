class InvitationsController < ApplicationController
  before_action :find_invitation

  def edit
    @invitation.accept(current_user) # CHANGE MEMBERSHIP STATUS
    redirect_to user_path(current_user)
  end

  def destroy
    @invitation.decline
    redirect_to user_path(current_user)
  end

  private

  def find_invitation
    @invitation = Invitation.find(params[:id])
  end
end
