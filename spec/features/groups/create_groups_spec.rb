require 'feature_helper'

describe 'creating groups' do

  @sagar = User.create(first_name: "Sagar", last_name: "Patel", email: "example@example.com", password: "testpassword", password_confirmation: "testpassword")

  xit 'should have a form to create groups' do
    visit new_session_path
    fill_in 'email', with: 'example@example.com'
    fill_in 'password', with: 'testpassword'
    click_button('Login')
    visit new_group_path
    expect(page).to have_css('form#group_form')
  end

  xit 'should create a group when form is submitted' do
    visit new_group_path
    fill_in 'group_name', with: 'Flatiron Gift Exchange'
    fill_in 'group_description', with: 'Student Secret Santa gift exchange of 2016!'
    fill_in "group_exchange_date", with: "2016/12/24"
    fill_in 'group_max_price', with: '50'
    fill_in 'invitations', with: 'jeff@example.com, ian@example.com, avi@example.com, adam@example.com'
    click_button('Create Group')
    expect(page).to have_css('div#create_group_success')
  end
end
