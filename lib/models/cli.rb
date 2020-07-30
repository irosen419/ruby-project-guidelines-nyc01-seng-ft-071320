require 'pry'
class Cli
    include Art::InstanceMethods

    def startup #change to launchpoint
        input= gets.strip.downcase
        start_menu=["login","log in","sign up","signup","browse"]
        user = nil
        until input=="exit"do
            user=User.login if input == "login" || input == "log in"
            user=User.sign_up if input == "sign up" || input == "signup"
            user=User.default_user if input == "browse"
            input = turn(user) if user
            user=nil if input == "logout" || input == "log out"
            welcome if input == "logout" || input == "log out"
            puts "You are currently not login.\nYou need to sign up or log in\nOr just browse" if user==nil
            input=gets.strip.downcase if input != "exit"
        end
        goodbye
    end

    def turn(user) #main_menu
        input = ""
        until input=="exit" || input== "logout" || input== "log out" do  
            user.donation_page if input== "donate" # make this its own thing
            # "test" if input== "test" # we use this line to test new commands for menu
            user.remove_animal if input == "delete"
            user.search if input== "search"
            user.top if input=="rankings"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            user.change_user_info if input == "update"
            input = instructions
        end 
        input="exit" if input != "logout" && input != "log out"
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