# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  validates :first_name, :last_name, :email, :password_digest, presence: true
  validates :email, uniqueness: true, email: true
  validates :password, length: { minimum: 6 }
end
