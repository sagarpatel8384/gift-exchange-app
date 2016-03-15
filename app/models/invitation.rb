# == Schema Information
#
# Table name: invitations
#
#  id                :integer          not null, primary key
#  email             :string
#  group_id          :integer
#  membership_status :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Invitation < ActiveRecord::Base
  belongs_to :group
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
