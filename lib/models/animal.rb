require 'pry'
class Animal < ActiveRecord::Base
    belongs_to :donation
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
                data["Species"].each do |indiv_animal| 
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

    def self.top_five
        aoa = id_occurence_in_favorites.sort_by{|k, v| -v}
        aoa = aoa.map {|array| array[0]}.map{|id| self.all.find(id)}[0...5]
        counter = 1
        puts "\nThe following five animals are very loved by our visitors.\nThey believe all animals should be loved.\nDont't you want to love them and love other animals too?!\n"
        aoa.each do |animal|
            puts "#{counter}. #{animal.common_name.capitalize}: #{animal.category.capitalize}"
            counter += 1
            puts "\n\n" if count == 5
        end
        puts "Type 'any' key to leave these five adorable animals"
        input=gets.strip.downcase
        sleep(0.75)
        input
    end

    def self.lonely_animals
        array = self.all.select {|animal| animal.favorites.length == 0}
        num= array.count
        puts "\nThere are still #{num} animals that are not on anyone's favorite list.\nFive of these very lonely animals are looking for a kind soul to love them.\nAre you a kind soul?\n"
        array= array.sample(5)
        counter = 1
        array.each do |animal|
            puts "#{counter}. #{animal.common_name.capitalize}: #{animal.category.capitalize}"
            counter += 1
            puts "\n\n" if counter == 6
        end
        puts "Type 'any' key to leave these sad animals to cry. They just wanted to be wanted.\nDon't everyone deserved to be loved sometimes. Please find and friend them."
        input=gets.strip.downcase
        sleep(0.75)
        input
    end

end
