ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  DatabaseCleaner.strategy = :truncation
  config.after(:all) do
    DatabaseCleaner.clean
  end
  config.before(:each) do
    # USER FIXTURES
    @sagar = User.create(first_name: "Sagar", last_name: "Patel", email: "example@example.com", password: "example", password_confirmation: "example")

    # GROUP FIXTURES
    @flatiron = Group.create(name: "Flatiron", description: "Flatiron gift exchange for fall 2016 graduation!", exchange_date: "2016-12-24", max_price: 40, admin_id: @sagar.id)
    @work = Group.create(name: "work", description: "Work gift exchange for fall 2016 party!", exchange_date: "2016-12-14", max_price: 50, admin_id: @sagar.id)
    @invalid_group = Group.create(name: "work", description: "Work gift exchange for fall 2016 party!", exchange_date: "2015-12-14", max_price: 50, admin_id: @sagar.id)

    @sagar.groups << @flatiron
    @sagar.groups << @work

    # INVITATION FIXTURES
    @invite_one = @flatiron.invitations.build(email: "example@example.com")
    @invite_two = @flatiron.invitations.build(email: "test@example.com")
    @invite_three = @flatiron.invitations.build(email: "test@example.com")
    @invite_one.save
    @invite_two.save
    @invite_three.save
  end
end
