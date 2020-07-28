require 'rest-client'
require 'json'
require 'pry'

Animal.delete_all
#http://apps.des.qld.gov.au/species/?op=getclassnames&kingdom=animals #Main Link

animals_response = RestClient.get("http://apps.des.qld.gov.au/species/?op=getfamilynames&kingdom=animals&class=mammalia")
animals_data = JSON.parse(animals_response)
family=animals_data["Family"]
#We are going throught the mammals link and we are going to extract information
#The first layer is family and it is an array "family[0]"
#In each of the family elements of array, we are going to access the speciesurl
#in the family array, we did another JSON with the speciesurl.
#using the speciesurl, we have different animals (can be 1 or many). we will run a each loop to capture the animals
animal = nil
family.each do |animal_hash|
    url=animal_hash["SpeciesUrl"]
    response= RestClient.get(url)
    data=JSON.parse(response)
    data["Species"].each do |indiv_animal| #ScientificName
        if indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["EPBCStatus"]
            Animal.create(scientific_name: indiv_animal["ScientificName"], common_name: indiv_animal["AcceptedCommonName"], category: indiv_animal["ConservationStatus"]["EPBCStatus"])
        elsif indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["NCAStatus"] && !indiv_animal["ConservationStatus"]["EPBCStatus"]
            Animal.create(scientific_name: indiv_animal["ScientificName"], common_name: indiv_animal["AcceptedCommonName"], category: indiv_animal["ConservationStatus"]["NCAStatus"])
            # binding.pry
            # puts animal.scientific_name
        end
        #puts "I pried"
    end
    # binding.pry
end

 # "search"   elsif input == "search"
                #user can utilize our search function
                # puts "What would you like to search by?"
                # puts "please type 'stop' to end search"
                # search_input=""
                # until search_input=="stop"
                    #     #1  or category
                    #     #2 or common_name
                    #     #3 or species
                    #     if search_input== "1" || search_input=="category"
                    #     elsif search_input=="2" || search_input=="common" || search_input=="common name"
                    #     elsif search_input=="3" || search_input=="species"
                    #     end
                    #
                    #        search_input=gets.chomp.downcase