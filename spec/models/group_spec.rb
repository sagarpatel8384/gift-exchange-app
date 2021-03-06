require 'rails_helper'

describe Group do
  describe "data" do
    it "has a name" do
      expect(@flatiron.name).to eq("Flatiron")
    end

    it "has a description" do
      expect(@flatiron.description).to eq("Flatiron gift exchange for fall 2016 graduation!")
    end

    it "has an exchange date" do
      expect(@flatiron.exchange_date).to eq("2016-12-24")
    end

    it 'has a valid exchange date' do
      expect(@invalid_group).to be_invalid
    end

    it "has a max price" do
      expect(@flatiron.max_price).to eq(40)
    end
  end

  describe "associations" do
    it "has an admin of class User" do
      expect(@flatiron.admin.class).to eq(User)
    end

    it "has an admin with a first name" do
      expect(@flatiron.admin.first_name).to eq("Sagar")
    end

    it "has many invites"  do
      expect(@flatiron.invitations.count).to eq(2)
    end
  end
end
