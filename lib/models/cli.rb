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
        instructions(user)
        input=gets.strip.downcase
        until input=="exit" do #input== "logout" 
            #binding.pry
            help if input== "help"
            "test" if input== "test"
            user.search if input== "search"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            user.change_user_info if input == "update user" #update is updating user nickname, update username, update password
            user.remove_animal if input == "delete"
            instructions
            input=gets.chomp.downcase
        end 
        input="exit"
    end

    def runtime
        welcome 
        startup
    end
    
    private 

    def instructions(user)
        puts "      Welcome back, #{user.display_name}!"
        puts "You are in the 'Main Menu. Please enter a command"
        puts "   Please type 'help' for a list of commands"
        puts "   You can always type 'exit' to exit screen"
    end 

end 