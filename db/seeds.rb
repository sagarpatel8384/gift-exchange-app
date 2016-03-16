require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

# USERS
@sagar = User.create(first_name: 'Sagar', last_name: 'Patel', email: 'sagar@example.com', password: 'sagarexample', password_confirmation: 'sagarexample')
@leon = User.create(first_name: 'Leon', last_name: 'Harary', email: 'leon@example.com', password: 'leonexample', password_confirmation: 'leonexample')
@justin = User.create(first_name: 'Justin', last_name: 'Curhan', email: 'justin@example.com', password: 'justinexample', password_confirmation: 'justinexample')

50.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'testpassword',
    password_confirmation: 'testpassword'
  )
end

# GROUPS
Group.create(name: 'Flatiron Gift Swap', description: '2016 Slackbeef Holiday Gift Exchange', exchange_date: '2016-12-2', max_price: 50, admin_id: @sagar.id)

group_name = ['Office', 'Friends', 'School']
party_name = ['Holiday Party', 'Gift Exchance', 'Gift Swap', '2016 Party']
dates = %w(2016-12-2 2016-12-24 2016-11-10 2016-12-2 2016-12-2)

10.times do
  Group.create(
    name: "#{group_name.sample} #{party_name.sample}",
    description: Faker::Lorem.sentence(5),
    exchange_date: (Date.today + 1 + rand(1..200)).strftime('%Y/%m/%d'),
    max_price: rand(25..100),
    admin_id: rand(1..50)
  )
end

# INVITATIONS
