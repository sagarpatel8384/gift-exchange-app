class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }

  def open_invitations
    Invitation.where('email = ? AND membership_status = ?', self.email, false)
  end
end
