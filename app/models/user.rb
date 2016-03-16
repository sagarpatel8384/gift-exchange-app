class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }, on: :create
  validates :bio, length: { maximum: 1000 }

  def open_invitations
    Invitation.where('email = ? AND membership_status = ?', self.email, 'pending')
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
