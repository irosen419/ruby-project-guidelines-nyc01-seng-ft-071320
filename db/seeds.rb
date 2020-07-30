require 'rest-client'
require 'json'
require 'pry'

#JSON
Charity.delete_all
Animal.delete_all

#Class methods
User.delete_all
Favorite.delete_all
Donation.delete_all

#JSON
Animal.get_database_animals_gov_au
Charity.get_charity

#Class method seeds
Favorite.create_favs #creates users and favorites
Donation.create_donations

binding.pry
puts "I pried into somewhere I shouldn't have..."
