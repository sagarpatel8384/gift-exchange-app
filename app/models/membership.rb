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
    receiver_id ? User.find(receiver_id).full_name : nil
  end
end
