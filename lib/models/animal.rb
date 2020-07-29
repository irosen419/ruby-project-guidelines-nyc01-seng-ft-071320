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

    def self.id_occurence_in_favorites
        Favorite.all.each_with_object(Hash.new(0)) {|key, hash| hash[key.animal_id] += 1}
    end

    def self.descending_popularity
        aoa = id_occurence_in_favorites.sort_by{|k, v| -v}
        aoa.map {|array| array[0]}.map{|id| self.all.find(id)}[0...5] 
    end

    def self.ascending_popularity
        aoa = id_occurence_in_favorites.sort_by{|k, v| v}
        aoa.map {|array| array[0]}.map{|id| self.all.find(id)}[0...5]
    end

    def self.lonely_animals
        self.all.select {|animal| animal.favorites.length == 0}.sample(5)
    end

end