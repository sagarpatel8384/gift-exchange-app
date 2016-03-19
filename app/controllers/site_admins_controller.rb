class SiteAdminsController < ApplicationController
  before_action :site_admin?

  def show
    @avg_ages = User.average_user_age
    @state_count = User.user_state_count
    @country_count = User.user_country_count
    @membership_stats = Invitation.percent_membership_status
    @num_active_groups = Group.num_active_groups
    @avg_group_size = Group.avg_group_size
    @defunct_groups_count = Group.num_defunct_groups_count
    @avg_gift_by_state = Group.gift_amount_by_state
    @avg_gift_by_country = Group.gift_amount_by_country
  end

  private

  def site_admin?
    redirect_to current_user if !current_user.site_admin?
  end
end
