class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitations
  belongs_to :admin, class_name: :User, foreign_key: 'admin_id'
  validates :name, :exchange_date, :max_price, :admin_id, presence: true
  validates :name, length: { in: 3..25 }
  validates :max_price, numericality: { only_integer: true, greater_than: 0 }
  validate :valid_exchange_date

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
    self.joins(:memberships).where('groups.exchange_date >= ?', Date.today).group('groups.id').having('count(groups.id) > 1').count.length
  end

  def self.num_inactive_groups
    self.joins(:memberships).group("groups.id").having("count(groups.id) > 1 AND groups.exchange_date < ?", Date.today).count.length
  end

  def self.num_defunct_groups
    self.joins(:memberships).group("groups.id").having("count(groups.id) = 1 AND groups.exchange_date < ?", Date.today).count.length
  end

  def self.avg_group_size
    "%.2f" % (self.count.to_f / Membership.count)
  end

  def self.gift_amount_by_state
    gift_by_state = self.joins(:users).group("state").average("max_price")
    gift_by_state.each_with_object({}) { |(state, avg_gift), hsh| hsh[state] = "%.2f" % avg_gift.to_f }
  end

  def self.gift_amount_by_country
    gift_by_country = self.joins(:users).group("country").average("max_price")
    gift_by_country.each_with_object({}) { |(country, avg_gift), hsh| hsh[country] = "%.2f" % avg_gift.to_f }
  end
end
