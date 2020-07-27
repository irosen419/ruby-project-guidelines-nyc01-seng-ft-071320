# require 'rest-client'
# require 'json'
require 'pry'

Animal.delete_all

# animals_response = RestClient.get("http:///api/v3/species/page/:1?token='YOUR TOKEN'")
# animals_data = JSON.parse(users_response)

# animals_data.each do |animal_hash|
#     Animal.create(animal_hash)
# end

Animal.create(scientific_name: "Loxodonta africana", common_name: "African Elephant", category: "VU")
Animal.create(scientific_name: "Varanus komodoensis", common_name: "Komodo Dragon", category: "VU")
Animal.create(scientific_name: "Delphinapterus leucas", common_name: "Beluga Whale", category: "LC")
Animal.create(scientific_name: "Gorilla beringei", common_name: "Mountain Gorilla", category: "EN")
Animal.create(scientific_name: "Elephas maximus", common_name: "Asian Elephant", category: "EN")
Animal.create(scientific_name: "Chelonia mydas", common_name: "Green Turtle", category: "EN")
Animal.create(scientific_name: "Cetorhinus maximus", common_name: "Baskin Shark", category: "EN")
Animal.create(scientific_name: "Canis simensis", common_name: "Ethiopian Wolf", category: "EN")
Animal.create(scientific_name: "Gymnogyps californianus", common_name: "California Condor", category: "CR")
Animal.create(scientific_name: "Carcharhinus longimanus", common_name: "Oceanic Whitetip Shark", category: "CR")
Animal.create(scientific_name: "Sphyrna lewini", common_name: "Scalloped Hammerhead", category: "CR")
Animal.create(scientific_name: "Diceros bicornis", common_name: "Black Rhino", category: "CR")
Animal.create(scientific_name: "Rhincodon typus", common_name: "Whale Shark", category: "EN")
Animal.create(scientific_name: "Okapia johnstoni", common_name: "Okapi", category: "EN")
Animal.create(scientific_name: "Balaenoptera musculus", common_name: "Blue Whale", category: "EN")
Animal.create(scientific_name: "Giraffa camelopardalis", common_name: "Giraffe", category: "VU")


# binding.pry

# puts "I BINDED THE ALL THE PRIES"