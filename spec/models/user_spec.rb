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
      expect(@sagar.password_digest).not_to be_nil
    end    
  end

  describe "associations" do 
    it "has many groups"  do
      expect(@sagar.groups.count).to eq(2)
    end
  end


end