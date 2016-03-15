# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  group_id    :integer
#  receiver_id :integer
#  joined      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
