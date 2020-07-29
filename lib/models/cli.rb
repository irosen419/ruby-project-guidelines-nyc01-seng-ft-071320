require 'pry'
class Cli
    include Art::InstanceMethods

    def startup
        input= gets.strip.downcase
        user ="start up has failed"
        if input=="exit"
            user=goodbye
        elsif input == "login"
            user=User.login
            if user == false
                puts "Your username or password is incorrect. Please type 'login' to try again or type 'signup' to signup."
                startup
            end
            user 
        elsif input == "sign up" || input == "signup"
            user=User.sign_up
            if user==false
                puts "Sorry! Username is already taken."
                startup
            end 
            user
        else
            startup
        end
        user
    end

    def help
        puts "                                     "
        puts "  I can accept the following commands"
        puts "- help      : displays this help message"
        puts "- list      : displays a list of all animals, ten at a time"
        puts "- favorites : displays your list of favorite animals"
        puts "- search    : search of new animals to add to your list"
        puts "- update    : update your username, password or display name"
        puts "- exit      : exits this program"
#        puts "Those are the commands that are available"
    end

    # def runtime
    #     welcome 
    #     user = startup
    #     turn(user)
    # end

    def turn(user)
        instructions
        input=gets.chomp.downcase
        until input== "exit" do
            #binding.pry
            help if input== "help"
            "test" if input== "test"
            user.search if input== "search"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            user.change_user_info if input == "update" #update is updating user nickname, update username, update password
            user.remove_animal if input == "delete"
            instructions
            input=gets.chomp.downcase
        end 
        goodbye
    end

    # def data_gather (url)
    #     animals_response = RestClient.get("http://apps.des.qld.gov.au/species/?op=getfamilynames&kingdom=animals&class=mammalia")
    #     animals_data = JSON.parse(animals_response)
    #     family=animals_data["Family"]
    #         animal = nil
    #         family.each do |animal_hash|
    #             url=animal_hash["SpeciesUrl"]
    #             response= RestClient.get(url)
    #             data=JSON.parse(response)
    #             data["Species"].each do |indiv_animal| #ScientificName
    #                 if indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["EPBCStatus"]
    #                     Animal.create(scientific_name: indiv_animal["ScientificName"], common_name: indiv_animal["AcceptedCommonName"], category: indiv_animal["ConservationStatus"]["EPBCStatus"])
    #                 elsif indiv_animal["ConservationStatus"]["ConservationSignificant"] == true && indiv_animal["ConservationStatus"]["NCAStatus"] && !indiv_animal["ConservationStatus"]["EPBCStatus"]
    #                     Animal.create(scientific_name: indiv_animal["ScientificName"], common_name: indiv_animal["AcceptedCommonName"], category: indiv_animal["ConservationStatus"]["NCAStatus"])
    #                 end
    #             end
    #         end
    #     end
    
    private 
    def instructions
        puts "                         "
        puts "Please enter a command"
        puts "Please type 'help' if you would like a list of commands"
        puts "You can always type 'exit' to exit screen"
    end 

end 