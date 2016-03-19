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

  # CLASS ANALYTICS

  def self.total_invitations
    Invitation.count
  end

  def self.total_accepted
    Invitation.where('membership_status = ?', 'accepted').count
  end

  def self.total_pending
    Invitation.where('membership_status = ?', 'pending').count
  end

  def self.total_declined
    Invitation.where('membership_status = ?', 'declined').count
  end

  def self.percent_membership_status
    percent_accepted = (self.total_accepted.to_f / self.total_invitations) * 100
    percent_pending = (self.total_pending.to_f / self.total_invitations) * 100
    percent_declined = (self.total_declined.to_f / self.total_invitations) * 100
    { accepted: percent_accepted, pending: percent_pending, declined: percent_declined }
  end
end
