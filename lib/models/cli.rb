require 'pry'
class Cli
    include Art::InstanceMethods

    def startup #change to launchpoint
        input= gets.strip.downcase
        user = nil
        until input=="exit"do
            user=User.login if input == "login" || input == "log in"
            user=User.sign_up if input == "sign up" || input == "signup"
            user=User.default_user if input == "browse"
            input = turn(user) if user
            welcome if input == "logout"
            puts "Incorrect Input! You need to sign up or log in" if user==nil
            input=gets.strip.downcase if input != "exit"
        end
        goodbye
    end

    def turn(user) #main_menu
        input = ""
        until input=="exit" || input== "logout" do  
            user.make_a_donation if input== "test" # make this its own thing
            user.search if input== "search"
            user.top if input=="rankings"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            user.change_user_info if input == "update"
            user.remove_animal if input == "delete"
            input = instructions
        end 
        
        input="exit" if input != "logout"
        input
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