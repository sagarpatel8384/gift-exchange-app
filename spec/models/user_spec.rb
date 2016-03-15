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

require 'rails_helper'

describe User do 
  describe "data" do
    it "has a first name" do
      expect(@sagar.first_name).to eq("Sagar")
    end

    it "has a last name" do
      expect(@sagar.last_name).to eq("Patel")
    end  

    it "has an email" do
      expect(@sagar.email).to eq("example@example.com")
    end

    it "has a password" do
      expect(@sagar.password).not_to be_nil
    end    
  end

  describe "associations" do 
    it "has many groups"  do
      expect(@sagar.groups.count).to eq(2)
    end
  end


end
