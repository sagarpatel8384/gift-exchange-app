# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  group_id    :integer
#  receiver_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.update_receiver_ids(match_pairs)
    match_pairs.each do |giver, receiver|
      giver.receiver_id = receiver.user_id
      giver.save
    end
  end

  def receiver_name
    update_receiver_ids ? User.find(receiver_id).full_name : nil
  end
end
