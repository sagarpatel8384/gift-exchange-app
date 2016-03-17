class MembershipsController < ApplicationController

  def update
    @group = Group.find(params[:id])
    mem_shuf = match_pairs(@group.memberships)
    Membership.update_receiver_ids(mem_shuf)
    redirect_to @group
  end  

end