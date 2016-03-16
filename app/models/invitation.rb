class Invitation < ActiveRecord::Base
  belongs_to :group
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, uniqueness: { scope: :group_id }

  def accept(user)
    user.groups << group
    self.membership_status = 'accepted'
    self.save
  end

  def decline
    self.membership_status = 'declined'
    self.save
  end
end
