# STATES & COUNTRIES

states_db = %w(AK AL AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)

states_db.each { |state| State.create(name: state) }

countries_db = ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Côte d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Democratic People's Republic of Korea (North Korea)", "Democratic Republic of the Cong", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic (Laos)", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia (Federated States of)", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea (South Korea)", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Tajikistan", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom of Great Britain and Northern Ireland", "United Republic of Tanzania", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]

countries_db.each { |country| Country.create(name: country) }

# REAL_USERS
@sagar = User.create(
  first_name: 'Sagar', last_name: 'Patel', email: 'sagar@giftswap.com', password: 'testpassword',
  password_confirmation: 'testpassword', birthdate: '1983-10-7', city: 'New York', state: 'NY', country: 'United States of America'
)
@leon = User.create(
  first_name: 'Leon', last_name: 'Harary', email: 'leon@giftswap.com', password: 'testpassword',
  password_confirmation: 'testpassword', birthdate: '1991-4-23', city: 'New York', state: 'NY', country: 'United States of America'
)
@justin = User.create(
  first_name: 'Justin', last_name: 'Curhan', email: 'justin@giftswap.com', password: 'testpassword',
  password_confirmation: 'testpassword', birthdate: '1990-12-8', city: 'New York', state: 'NY', country: 'United States of America'
)

dates = %w(1980-12-2 1975-10-24 1990-11-10)

countries = [
  "United States", "Australia", "United Kingdom",
  "Canada", "Mexico", "Spain", "France", "Germany",
  "Italy", "Russia", "China", "India"
]

# AUTOMATED USERS
250.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'testpassword',
    password_confirmation: 'testpassword',
    birthdate: dates.sample,
    city: Faker::Address.city,
    state: states_db.sample,
    country: countries.sample
  )
end

# SITE ADMIN
@site_admin_sagar = SiteAdmin.create.tap { |site_admin| site_admin.user = @sagar }.save
@site_admin_leon = SiteAdmin.create.tap { |site_admin| site_admin.user = @leon }.save
@site_admin_justin = SiteAdmin.create.tap { |site_admin| site_admin.user = @justin }.save

# GROUPS
@flatiron = Group.create(name: 'Flatiron Gift Swap', description: 'Flatiron School Annual Holiday Party', exchange_date: '2016-12-2', max_price: 50, admin_id: @sagar.id)
@slackbeef = Group.create(name: 'SlackBeef Party', description: '2016 Slackbeef Holiday Gift Exchange', exchange_date: '2016-12-2', max_price: 50, admin_id: @leon.id)
@ruby_beginners = Group.create(name: 'Ruby Beginners Gift Swap', description: 'Ruby Beginners Holiday Gift Swap', exchange_date: '2016-12-2', max_price: 100, admin_id: @justin.id)

party_name = ['Holiday Party', 'Gift Exchance', 'Gift Swap', 'Party 2016', 'Annual Fun Time', 'Secret Santa', 'Hanukkah Party']
dates = %w(2016-12-2 2016-12-24 2016-11-10 2016-12-2 2016-12-2)

50.times do
  Group.create(
    name: "#{Faker::Company.name} #{party_name.sample}",
    description: Faker::Lorem.sentence(5),
    exchange_date: (Date.today + 1 + rand(1..200)).strftime('%Y/%m/%d'),
    max_price: rand(25..100),
    admin_id: rand(5..250)
  )
end

# MEMBERSHIPS
@sagar.groups << @ruby_beginners
@leon.groups << @ruby_beginners
@justin.groups << @ruby_beginners

all_users = User.all
all_groups = Group.all

all_groups.each do |group|
  rand(8).times { group.users << all_users.sample }
end

# INVITATIONS
@flatiron.invitations.create(email: 'leon@giftswap.com')
@flatiron.invitations.create(email: 'justin@giftswap.com')

@slackbeef.invitations.create(email: 'sagar@giftswap.com')
@slackbeef.invitations.create(email: 'justin@giftswap.com')

@ruby_beginners.invitations.create(email: 'sagar@giftswap.com')
@ruby_beginners.invitations.create(email: 'leon@giftswap.com')

######################
# SAMPLE
######################
@campus_draft = Group.create(name: 'Campus Draft Gift Exchange', description: 'Campus Draft Gift Exchange 2016', exchange_date: '2016-12-24', max_price: 100, admin_id: @sagar.id)

@campus_draft.users << @sagar

10.times do |i|
  User.find(i + 10).groups << @campus_draft
end

@campus_draft.save
