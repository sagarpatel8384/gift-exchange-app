class User < ActiveRecord::Base
  has_many :matches
  has_many :groups, through: :matches
end
