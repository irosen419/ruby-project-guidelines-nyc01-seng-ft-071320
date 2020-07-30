class User < ActiveRecord::Base
    has_many :favorites
    has_many :animals, through: :favorites
    has_many :donations
    has_many :charities, through: :donations

    include Art::InstanceMethods

    def self.login
        puts "Welcome Back! What is your Username?"
        name = gets.strip
        user = User.find_by(username: name)
        if name == "exit" || user ==nil #if you type in a name that login cannot find, there is nothing
            puts "We were not able to find a user with the Username provided" if user == nil
            puts "You have chosen to leave the login screen" if name == "exit"
            puts "You need to signup, login, or browse to access our animals!"
            user = false     
        else
            puts "What is your password?" 
            password = gets.strip #if no user, then this will trigger CLI to relaunch
            puts "You have typed the wrong password " if password != user.password 
            puts "You need to signup, login, or browse to access our animals!" if password != user.password 
            user = false if password != user.password #if user signs in correctly, then user is used in CLI APP. 
        end
        user
    end

    def self.sign_up
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
    
    def my_favorites
        Favorite.all.where(user_id: self.id)
    end

    def see_favorites
        if self.my_favorites.empty?
            no_favorites #This is just words in art"
        else
            puts "------------"
            puts "MY FAVORITES"
            puts "------------"
            count = 1
            array_of_favs = []
            self.my_favorites.each do |favorite|
                Animal.all.each do |animal|
                    if animal.id == favorite.animal_id
                        array_of_favs << "#{count}. #{animal.common_name.capitalize} | Scientific name: #{animal.scientific_name.capitalize} | Conservation status: #{animal.category.capitalize}.\n\n"
                        count += 1
                    end  
                end
            end
            input = nil
            anny = array_of_favs
            current = 0
            until input == "exit" do
                show_length = anny[current...current+5].each {|fav| puts fav}
                current += 5
                input = "exit" if show_length.length < 5
                puts "\n Type 'exit' if you would like to exit or any key to see more favorites."
                input = gets.chomp if show_length.length >= 5

            end
        end
    end

    def list_animals #doesn't add to favorite when typing in animal name after list
        anny= Animal.all.map {|animal| animal.common_name}.shuffle
        current=0
        puts "\n Here are 10 animals"
        input = nil
        until anny.include?(input) || input == 'exit' do
            test_length = anny[current...current+10].each do |animal|
                puts animal.capitalize
            end
            current += 10
            input = 'exit' if test_length.length < 10
            puts "\n Type 'next' to see more animals or type 'exit' to exit."
            input = gets.chomp.downcase if test_length.length >= 10
        end
        input
    end

    def create_favorite
        puts "\n Please choose one animal, by their common name, from the following list: "
        input = list_animals
        return if input == 'exit' || !input
        name_search(input)
    end

    def remove_animal
        if self.my_favorites.empty?
            no_favorites #This is just a method for words
        else
            puts "\n Please choose one animal, by their common name, from the following list:"
            self.see_favorites
            input = gets.chomp.downcase
            animal = Animal.all.find_by(common_name: input)
            animal_to_delete = Favorite.all.find_by(user_id: self.id, animal_id: animal.id)
            animal_to_delete.delete
        end
    end
    
    def search
        input=""
        until input == "exit" do
            search_by_animal if input == "animal"
            search_by_category if input == "category"
            input = search_instructions
        end
        puts "Thank you for searching"
    end

    def search_by_animal
        puts "\n You may type the full name or partial name of the animal you are looking for: "
        animal_input = gets.chomp.downcase
        puts "\n"
        animal_array = Animal.all.select do |animal|
            animal.common_name.include?(animal_input)
        end
        if animal_array.length > 0
            animal_array.each {|animal| puts animal.common_name.capitalize}
            favoritize_after_search
        elsif animal_array.length == 0
            puts "\n Sorry, there are no threatened #{animal_input.pluralize} in Australia. Please try again.\n\n"
        end
    end

    def search_by_category
        puts "\n The available categories are: Vulnerable, Endangered, Critically Endangered, Near threatened, Extinct, Special least concern, Conservation Dependent, Least concern, Extinct in the wild"
        puts "Which category would you like to view?"
        input = gets.chomp.downcase
        category_array = Animal.all.where(category: input)
        category_array.each { |animal| puts animal.common_name.capitalize}

        favoritize_after_search
    end  

    def favoritize_after_search
        puts "\n Please type the animal that you want to add to your favorites."
        input=gets.chomp.downcase
        until input == "exit"
            search = name_search(input)
            puts "\n You have added #{input.capitalize} to your favorites! (FS version)" if search != nil #FS version needs to be taken out if we still want this to be implemented
            input = "exit"
        end
    end

    def name_search(input)
        animal_input = input
        animal = Animal.all.find_by(common_name: animal_input)
        Favorite.find_or_create_by(user_id: self.id, animal_id: animal.id) if animal 
        puts "\n You have added #{input.capitalize} to your favorites!\n (NS Version)" if animal #James added this line Thursday for the added animal feature. 
        puts "\n You might have mispelled that name. Please try again.\n" if !animal #Live above might be duplicated by favoritize, we might have to remove that line
    end
    
    def change_user_info
        puts "    You can make the following changes to your account"
        menu = ["top          : update your password","password     : update your password", "username     : update your username", "display name : update your display name", "exit         : return to the main menu"].sort_by { |word| word.downcase }    
        menu.each{|item|puts "- #{item}"}
        input = gets.strip.downcase
        if input == "username"
            puts "Please type in your new username:"
            name_input = gets.strip
                self.update(username: name_input)
        elsif input == "password"
            puts "Please type in your new password:"
            password_input = gets.strip
                self.update(password: password_input)
        elsif input == "display name"
            puts "Please type in your new display name:"
            display_input = gets.strip
                self.update(display_name: display_input)
        end
    end

    def self.default_user
        User.create(username: "Unknown-Browser", password: "irosen1234", display_name: "Guest")
    end

    def top
        input = top_instructions
        Animal.lonely_animals if input == "sad"
        Animal.top_five if input == "top"
    end
end
