require 'pry'
class Cli
    include Art::InstanceMethods

    def startup 
        input= gets.strip.downcase
        sleep(0.75)
        start_menu=["login","log in","sign up","signup","browse"]
        user = nil
        until input=="exit"do
            user=login if input == "login" || input == "log in"
            user=sign_up if input == "sign up" || input == "signup"
            user=default if input == "browse"
            input = turn(user) if user
            user=nil if input == "logout" || input == "log out"
            welcome if input == "logout" || input == "log out"
            puts "You are currently not logged in.\nYou need to sign up or log in\nOr just browse" if user==nil
            input=gets.strip.downcase if input != "exit"
            sleep(0.75)
            input
        end
        goodbye
    end

    def turn(user) 
        input = ""
        until input=="exit" || input== "logout" || input== "log out" do  
            user=user
            user.donation_page if input== "donate"
            user.remove_animal if input == "delete"
            user.search if input== "search"
            user.top if input=="rankings"
            user.list_animals if input== "list"
            user.see_favorites if input == "favorites"
            user.create_favorite if input == "add"
            input=user.change_user_info if input == "update"
            input = instructions if input!= "exit" && input!="logout"
        end 
        input="exit" if input != "logout" && input != "log out"
        input
    end

    def login
        puts "Welcome Back! What is your Username?"
        name = gets.strip
        sleep(0.75)
        user = User.find_by(username: name)
        if name == "exit" || user ==nil 
            puts "We were not able to find a user with the Username provided" if user == nil
            puts "You have chosen to leave the login screen" if name == "exit"
            user = false     
        else
            puts "What is your password?" 
            password = gets.strip 
            sleep(0.75)
            puts "You have typed the wrong password " if password != user.password 
            puts "You need to signup, login, or browse to access our animals!" if password != user.password 
            user = false if password != user.password 
        end
        user 
    end

    def sign_up
        user = puts "Please enter your username: "
        name = gets.strip
        sleep(0.75)
        if name=="exit" || User.find_by(username: name)
            puts "#{name} is already taken." if User.find_by(username: name)
            puts "You have chosen to leave the sign up screen" if name == "exit"
            puts "You need to signup, login, or browse to access our animals!"
            user=false
        else
            puts "Your username is #{name}. Please keep track of it."
            puts "Enter a password: "
            password = gets.strip
            sleep(0.75)
            user = User.create(username: name, password: password, display_name: nil)
            puts "Would you like a nickname that we can address by? (Y/N)"
            input = gets.strip
            sleep(0.75)
            if input.downcase == "y"
                puts "What would you like that name to be?"
                name_input = gets.strip
                sleep(0.75)
                puts "Great! Thanks, #{name_input}!"
                user.display_name = name_input
            else
                puts "Okay, no worries!"
            end
        end
        user
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