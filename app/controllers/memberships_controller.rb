class MembershipsController < ApplicationController
  def update
    @group = Group.find(params[:id])

    if @group.open
      mem_shuf = match_pairs(@group.memberships)
      Membership.update_receiver_ids(mem_shuf)
      @group.send_match_emails
      @group.close
      @group.save
    end
    
    redirect_to @group
  end
end
