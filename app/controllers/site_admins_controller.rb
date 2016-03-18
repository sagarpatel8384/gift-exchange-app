class SiteAdminsController < ApplicationController
  before_action :site_admin?

  def show
    @avg_ages = User.average_user_age
    @state_count = User.user_state_count
    @country_count = User.user_country_count
  end

  private

  def site_admin?
    if !current_user.site_admin?
      redirect_to current_user
    end
  end
end
