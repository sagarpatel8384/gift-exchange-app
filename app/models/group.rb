# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  exchange_date :datetime
#  max_price     :integer
#  admin_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, :exchange_date, :max_price, :admin_id, presence: true
  validates :name, length: { in: 3..25 }
  validates :max_price, numericality: { only_integer: true }
end
