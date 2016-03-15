require 'rails_helper'

describe Invitation do 
  describe "data" do
    it "has an email" do
      expect(@invite_one.email).to eq("example@example.com")
    end

    it "has a membership status that defaults to false" do
      expect(@invite_one.membership_status).to eq(false)
    end 
  end 

  describe "associations" do 
    it "belongs to a group"  do
      expect(@invite_one.group.class).to eq(Group)
    end

#     it "validates uniqueness of email in a group"  do
#       expect(@invite_three.errors.full_messages.first).to eq("An invite has already been sent to this email address")
#     end
#   end
end