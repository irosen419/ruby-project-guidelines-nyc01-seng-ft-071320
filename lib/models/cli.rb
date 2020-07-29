require 'pry'
class Cli
    include Art::InstanceMethods

    def startup #change to launchpoint
        input= gets.strip.downcase
        user = nil
        until input=="exit"do
            user=User.login if input == "login"
            user=User.login if input == "log in"
            user=User.sign_up if input == "sign up"
            user=User.sign_up if input == "signup"
            # binding.pry
            user=User.default_user if input == "browse"
            # binding
            input = turn(user) if user
            # binding.pry
            puts "Incorrect Input! You need to sign up or log in" if user==nil
            input=gets.strip.downcase if input != "exit"
        end
        goodbye
    end

    def turn(user) #main_menu
        input = ""
        until input=="exit" do #input== "logout" 
            #binding.pry
            "test" if input== "test"
            user.search if input== "search"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            user.change_user_info if input == "update" #update is updating user nickname, update username, update password
            user.remove_animal if input == "delete"
            input = instructions
        end 
        input="exit"
    end

    def runtime
        welcome 
        startup
    end
    
    private 

    def default
        User.default_user
    end

end 