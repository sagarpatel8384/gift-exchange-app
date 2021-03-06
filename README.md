# Welcome to GiftSwap

GiftSwap is a web application built in the Ruby programming language using the Rails framework. GiftSwap is an application that allows users to create groups for gift exchange events (e.g., Secret Santa). Once a user has accepted a group invitation, the group admin has the ability to randomly generate gift exchange pairs.

A live demo of GiftSwap can be found here: [GiftSwap](https://giftswap.herokuapp.com/)

## GiftSwap Pairing

GiftSwap allows both registered and unregistered users to use our matching algorithm to match unique pairs for gift swaps. When first visiting the site, users are presented with a form which the user can use to match pairs.

![pair-form-unregistered.png](/app/assets/images/pair-form-unregistered.png)

##### Results

![pair-results-unregistered.png](/app/assets/images/pair-results-unregistered.png)

Once logged in, only users who are designated as 'group admins' are allowed to match members of a group.

### Pairing Algorithm

In order to assign unique partners within a GiftSwap group, we've written the following simple algorithm:

```ruby
def match_pairs(group)
  shuffled_group = shuffle_users(group)
  match_hash(shuffled_group)
end

def shuffle_users(group)
  group.to_a.shuffle
end

def match_hash(shuffled_group)
  shuffled_group.each_with_object({}).with_index do |(user, hash), index|
    hash[user] = shuffled_group[index + 1]
  end.tap { |matches| matches[shuffled_group.last] = shuffled_group.first }
end
```

The above code takes into account that no two people will be assigned each other as gift giver and receiver. The `match pairs` method does not currently take into account any user specified conditions.

## Data Analytics

In addition to the user experience, GiftSwap has built out a site administrator panel that provides visual representation of various user and group data. The below screenshots utilize the [chartkick](https://github.com/ankane/chartkick) gem.

![users by state](/app/assets/images/user-location-by-state.png)
![users by country](/app/assets/images/user-location-by-country.png)

##### Related code in respective models

```ruby
def self.average_user_age
  users_with_bdays = self.where('birthdate IS NOT NULL').select('birthdate')
  "%.2f" % (users_with_bdays.inject(0) { |sum, user| sum + user.age } / users_with_bdays.size)
end

def self.user_state_count
  users_with_state = self.where('state IS NOT NULL AND state != ?', "").select(:state).order(:state)
  users_with_state.each_with_object(Hash.new(0)) { |user, hash| hash[user.state] += 1 }
end

def self.user_country_count
  users_with_country = self.where('country IS NOT NULL AND country != ?', "").select('country')
  users_with_country.each_with_object(Hash.new(0)) { |user, hash| hash[user.country] += 1 }
end
```

![average gift value by state](/app/assets/images/average-gift-value-by-state.png)
![average gift value by country](/app/assets/images/average-gift-value-by-country.png)

##### Related code in respective models

```ruby
def self.gift_amount_by_state
  gift_by_state = Group.joins(:users).group("state").average("max_price")
  gift_by_state.each_with_object({}) { |(state, avg_gift), hsh| hsh[state] = "%.2f" % avg_gift.to_f }
end

def self.gift_amount_by_country
  gift_by_country = self.joins(:users).group("country").average("max_price")
  gift_by_country.each_with_object({}) { |(country, avg_gift), hsh| hsh[country] = "%.2f" % avg_gift.to_f }
end
```
![invitation status analytics](/app/assets/images/invitation-status-analytics.png)

##### Related code in respective models

```ruby
def self.total_invitations
  Invitation.count
end

def self.total_accepted
  Invitation.where('membership_status = ?', 'accepted').count
end

def self.total_pending
  Invitation.where('membership_status = ?', 'pending').count
end

def self.total_declined
  Invitation.where('membership_status = ?', 'declined').count
end

def self.percent_membership_status
  percent_accepted = (self.total_accepted.to_f / self.total_invitations) * 100
  percent_pending = (self.total_pending.to_f / self.total_invitations) * 100
  percent_declined = (self.total_declined.to_f / self.total_invitations) * 100
  { accepted: percent_accepted, pending: percent_pending, declined: percent_declined }
end
```

![user and group analytics](/app/assets/images/user-and-group-analytics.png)

##### Related code in respective models

```ruby
def self.average_user_age
  users_with_bdays = self.where('birthdate IS NOT NULL').select('birthdate')
  "%.2f" % (users_with_bdays.inject(0) { |sum, user| sum + user.age } / users_with_bdays.size)
end

def self.num_active_groups
  # Qualify as an active group if you have more than one member
  self.joins(:memberships).group('groups.id').having('count(groups.id) > 1').count.length
end

def self.avg_group_size
  # Total memberships divided by the number of active or non-active groups
  "%.2f" % (self.count.to_f / Membership.count)
end

def self.num_defunct_groups_count
  # Groups with one membership and date is after today
  self.joins(:memberships).group("groups.id").having("count(groups.id) = 1 AND groups.exchange_date < ?", Date.today).count.length
end
```

## Next Steps
We would like to build out the following features in the future:

1. Users can enter matching conditions (e.g., Spouses cannot be paired)
2. Implementation of a User wishlist table
3. Amazon Product Advertising API support for product search
4. Additional Group Admin data analytics
5. Update Group creation specs and add additional specs

## Authors

* Sagar Patel: [LinkedIn](https://www.linkedin.com/in/patelsagar) | [GitHub](https://github.com/sagarpatel8384)
* Leon Harary: [LinkedIn](https://www.linkedin.com/in/leonharary) | [GitHub](https://github.com/lharary)
* Justin Curhan: [LinkedIn](https://www.linkedin.com/in/justincurhan) | [GitHub](https://github.com/jcurhan)

## License

GiftSwap App is MIT Licensed. See LICENSE for details.
