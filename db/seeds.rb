require 'rest-client'
require 'json'
require 'pry'

# User.delete_all
# Animal.delete_all
# Favorite.delete_all
# Donation.delete_all

# Animal.get_database_animals_gov_au

User.create(username: "Ian", password: 1234, display_name: "E")
User.create(username: "James", password: 1234, display_name: nil)
User.create(username: "jennyoyo", password: 1234, display_name: "jenn")
User.create(username: "Tashawn", password: 1234, display_name: nil)
User.create(username: "Ian G", password: 1234, display_name: nil)
User.create(username: "Ryan W", password: 1234, display_name: nil)
User.create(username: "Cody", password: 1234, display_name: nil)
User.create(username: "Cody", password: 1234, display_name: "Cody.NYC")
User.create(username: "Ryan", password: 1234, display_name: nil)
User.create(username: "Brian", password: 1234, display_name: "Lego")

Animal.create(common_name: "elephant", scientific_name: "This that", category: "Endangered")
Animal.create(common_name: "giraffe", scientific_name: "That this", category: "Endangered")
Animal.create(common_name: "platypus", scientific_name: "Ooga booga", category: "Endangered")
Animal.create(common_name: "hippo", scientific_name: "Blah blah", category: "Endangered")
Animal.create(common_name: "wallaby", scientific_name: "beh beh", category: "Endangered")
Animal.create(common_name: "cat", scientific_name: "boo boo", category: "Endangered")
Animal.create(common_name: "bat", scientific_name: "batman", category: "Least concern")


Favorite.create(user_id: User.all[0].id, animal_id: Animal.all[0].id)
Favorite.create(user_id: User.all[1].id, animal_id: Animal.all[1].id)
Favorite.create(user_id: User.all[2].id, animal_id: Animal.all[3].id)
Favorite.create(user_id: User.all[3].id, animal_id: Animal.all[3].id)
Favorite.create(user_id: User.all[3].id, animal_id: Animal.all[4].id)
Favorite.create(user_id: User.all[4].id, animal_id: Animal.all[5].id)
Favorite.create(user_id: User.all[5].id, animal_id: Animal.all[6].id)
Favorite.create(user_id: User.all[2].id, animal_id: Animal.all[6].id)
Favorite.create(user_id: User.all[0].id, animal_id: Animal.all[6].id)

# https://apps.des.qld.gov.au/species/?op=getorganisations
# main_url = RestClient.get("https://apps.des.qld.gov.au/species/?op=getorganisations")
# charity_data = JSON.parse(main_url)


# charity_data["Organisation"].each do |charity_hash|
#     Charity.create(name: charity_hash["Name"].downcase, acronym: charity_hash["Acronym"], org_type: charity_hash["OrganisationType"])
# end


Donation.create(amount: 25, memo: "For the animals", user_id: User.all.first.id, charity_id: Charity.all.first.id, animal_id: Animal.all.first.id)
Donation.create(amount: 30, memo: "For the animals", user_id: User.all.first.id, charity_id: Charity.all.second.id, animal_id: Animal.all.second.id)
Donation.create(amount: 50, memo: "For the animals", user_id: User.all.first.id, charity_id: Charity.all.third.id, animal_id: Animal.all.third.id)
Donation.create(amount: 100, memo: "For the animals", user_id: User.all.second.id, charity_id: Charity.all.fourth.id, animal_id: Animal.all.fourth.id)
Donation.create(amount: 15, memo: "For the animals", user_id: User.all.last.id, charity_id: Charity.all.last.id, animal_id: Animal.all.last.id)

# Animal.get_database_animals_gov_au
Charity.get_charity
Donation.create_donations
Favorite.create_favs #creates users and favorites
binding.pry
puts "I pried into somewhere I shouldn't have"
