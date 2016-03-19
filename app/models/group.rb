class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitations
  belongs_to :admin, class_name: :User, foreign_key: 'admin_id'
  validates :name, :exchange_date, :max_price, :admin_id, presence: true
  validates :name, length: { in: 3..25 }
  validates :max_price, numericality: { only_integer: true, greater_than: 0 }
  # validate :valid_exchange_date

  def valid_exchange_date
    today = Date.today.strftime('%Y/%m/%d')
    errors.add(:exchange_date, "can't be in the past") if exchange_date < today
  end

  def admin_membership(current_user)
    self.admin = current_user
    self.users << current_user
  end

  def admin?(current_user)
   current_user == self.admin
  end

  # CLASS ANALYTICS

  def self.num_active_groups
    # Qualify as an active group if you have more than one member
    self.joins(:memberships).group('groups.id').having('count(groups.id) > 1').count.length
  end

  def self.avg_group_size
    # Total memberships divided by the number of active or non-active groups
    "%.2f" % (self.count.to_f / Membership.count)
  end

  def self.gift_amount_by_state
    gift_by_state = Group.joins(:users).group("state").average("max_price")
    gift_by_state.each_with_object({}) { |(state, avg_gift), hsh| hsh[state] = "%.2f" % avg_gift.to_f }
  end

  def self.gift_amount_by_country
    gift_by_country = self.joins(:users).group("country").average("max_price")
    gift_by_country.each_with_object({}) { |(country, avg_gift), hsh| hsh[country] = "%.2f" % avg_gift.to_f }
  end

  def self.num_defunct_groups_count
    # Groups with one membership and date is after today
    self.joins(:memberships).group("groups.id").having("count(groups.id) = 1 AND groups.exchange_date < ?", Date.today).count.length
  end
end
