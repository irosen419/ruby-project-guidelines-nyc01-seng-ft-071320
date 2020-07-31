require 'pry'
class Cli
    include Art::InstanceMethods

    def startup #change to launchpoint
        input= gets.strip.downcase
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
        end
        goodbye
    end

    #if we have time, we need to make sure other inputs gets a message

    def turn(user) #main_menu
        input = ""
        until input=="exit" || input== "logout" || input== "log out" do  
            user=user
            user.donation_page if input== "donate" # make this its own thing
            # "test" if input== "test" # we use this line to test new commands for menu
            input = user.remove_animal if input == "delete"
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
        user = User.find_by(username: name)
        if name == "exit" || user ==nil #if you type in a name that login cannot find, there is nothing
            puts "We were not able to find a user with the Username provided" if user == nil
            puts "You have chosen to leave the login screen" if name == "exit"
            user = false     
        else
            puts "What is your password?" 
            password = gets.strip #if no user, then this will trigger CLI to relaunch
            puts "You have typed the wrong password " if password != user.password 
            puts "You need to signup, login, or browse to access our animals!" if password != user.password 
            user = false if password != user.password #if user signs in correctly, then user is used in CLI APP. 
        end
        user #user is either, a user, a false statement, or nil
    end

    def sign_up
        user = puts "Please enter your username: "
        name = gets.strip
        if name=="exit" || User.find_by(username: name)
            puts "#{name} is already taken." if User.find_by(username: name)
            puts "You have chosen to leave the sign up screen" if name == "exit"
            puts "You need to signup, login, or browse to access our animals!"
            user=false
        else
            puts "Your username is #{name}. Please keep track of it."
            puts "Enter a password: "
            password = gets.strip
            user = User.create(username: name, password: password, display_name: nil)
            puts "Would you like a nickname that we can address by? (Y/N)"
            input = gets.strip
            if input.downcase == "y"
                puts "What would you like that name to be?"
                name_input = gets.strip
                puts "Great! Thanks, #{name_input}!"
                user.display_name = name_input
            else
                puts "Okay, no worries!"
            end
        end
        user
    end

#if you delete your account, you should be kicked out to the welcome screen
    def runtime
        welcome 
        startup
    end
    
    private 

    def default
        User.default_user
    end

end 