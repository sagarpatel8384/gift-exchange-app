class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_one :site_admin

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }, on: :create
  validates :bio, length: { maximum: 1000 }
  validate :valid_birthday

  def valid_birthday
    return if !birthdate
    valid_date = (Date.today.year - birthdate.year) < 112
    errors.add(:birthdate, 'must be valid') if !valid_date
  end

  def open_invitations
    Invitation.where('email = ? AND membership_status = ?', self.email, 'pending')
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def site_admin?
    !site_admin.nil?
  end

  def age
    (Time.new.to_date - self.birthdate.to_date).to_i / 365
  end

  # CLASS ANALYTICS

  def self.average_user_age
    users_with_bdays = self.where('birthdate IS NOT NULL').select('birthdate')
    "%.2f" % (users_with_bdays.inject(0) { |sum, user| sum + user.age } / users_with_bdays.size)
  end

  def self.user_state_count
    self.where('state IS NOT NULL AND state != ?', "").group('state').count('state')
  end

  def self.user_country_count
    self.where('country IS NOT NULL AND country != ?', "").group('country').count('country')
  end

  # INSTANCE ANALYTICS

  def total_gifts_received
    Membership.where("receiver_id = ?", self.id).count(:receiver_id)
  end

  def total_gifts_given
    Membership.where("user_id = ? AND receiver_id IS NOT NULL", self.id).count(:receiver_id)
  end

  def gifts_given_to
    Membership.where("user_id = ? AND receiver_id IS NOT NULL", self.id).collect(&:receiver_name)
  end

  def gifts_received_from
    Membership.where("receiver_id = ?", self.id).collect { |membership| membership.user.full_name }
  end
end
