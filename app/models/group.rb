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
end
