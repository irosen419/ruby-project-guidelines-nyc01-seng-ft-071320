class Cli
    include Art::InstanceMethods

    def startup
        puts "please type login or sign up"
        # puts "You can type exit to leave"
        input= gets.strip.downcase
        user ="start up has failed"
        if input=="exit"
            user=goodbye
        elsif input == "login"
            user=User.login
            if user == false
                puts "your username or password is incorrect"
                startup
            end
            user 
        elsif input == "sign up" || input == "signup"
            user=User.sign_up
            if user==false
                puts "username is already taken"
                startup
            end 
            user
        else
            startup
        end
        user
    end

    def help
        puts "  I can accept the following commands"
        puts "- help     : displays this help message"
        puts "- favorites : displays your list of favorite animals"
        puts "- search   : search of new animals to add to your list"
        puts "- exit     : exits this program"
        puts "Those are the commands that are available"
    end

    # def runtime
    #     welcome 
    #     user = startup
    #     turn(user)
    # end

    def turn(user)
        puts "Please enter a command"
        puts "Please type 'help' if you would like a list of commands"
        input=gets.chomp.downcase
        if input=="exit"
            goodbye
        elsif input=="help"
            help
            turn(user)
        elsif input == "favorites"
            user.see_favorites
            puts "You can 'add' to your favorites list"
            turn(user)
        elsif input == "add"
            user.create_favorite
            #user can add animals to favorite list
            turn(user)
        elsif input == "update" 
            #update is updating user nickname, update username, update password
            turn(user)
        elsif input == "delete"
            user.delete_animal
            #user can delete animals from users list
            turn(user)
        elsif input == "animals"
            #user can view animls from the users list
            turn(user)
        elsif input == "search"
            #user can utilize our search function
            puts "What would you like to search by?"
            puts "please type 'stop' to end search"
            search_input=""
            until search_input=="stop"
                
                #     #1  or category
                #     #2 or common_name
                #     #3 or species
                #     if search_input== "1" || search_input=="category"
                #     elsif search_input=="2" || search_input=="common" || search_input=="common name"
                #     elsif search_input=="3" || search_input=="species"
                #     end
                #
            search_input=gets.chomp.downcase
            end 
            turn(user)
        else 
            turn(user)
        end
    end

end 