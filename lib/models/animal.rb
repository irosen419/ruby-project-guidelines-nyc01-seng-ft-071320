require 'pry'
class Animal < ActiveRecord::Base
    has_many :favorites
    has_many :users, through: :favorites

    def self.get_database_animals_gov_au
        main_url = RestClient.get("http://apps.des.qld.gov.au/species/?op=getclassnames&kingdom=animals")
        animals_data = JSON.parse(main_url)
        animal_link = animals_data["Class"]
        links=[]
        animal_link.each do |group|
        links<<group["FamilyNamesUrl"]
        end
        links.each do |link|
            animals_response = RestClient.get(link)
            animals_data = JSON.parse(animals_response)
            family = animals_data["Family"]
            family.each do |animal_hash|
                url = animal_hash["SpeciesUrl"]
                response = RestClient.get(url)
                data = JSON.parse(response)
                data["Species"].each do |indiv_animal| #ScientificName
                    if indiv_animal["AcceptedCommonName"]
                        if indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["EPBCStatus"]
                            Animal.create(scientific_name: indiv_animal["ScientificName"].downcase, common_name: indiv_animal["AcceptedCommonName"].downcase, category: indiv_animal["ConservationStatus"]["EPBCStatus"].downcase)
                        elsif indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["NCAStatus"] && !indiv_animal["ConservationStatus"]["EPBCStatus"]
                            Animal.create(scientific_name: indiv_animal["ScientificName"].downcase, common_name: indiv_animal["AcceptedCommonName"].downcase, category: indiv_animal["ConservationStatus"]["NCAStatus"].downcase)
                        end
                    end
                end
            end
        end
    end

    def self.most_popular
        User.all.each do |user|
            array = user.favorites.map {|fav| fav.animal_id}
        end
    end

end