class User < ActiveRecord::Base
    has_many :favorites
    has_many :animals, through: :favorites
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
        puts "Please enter your username: "
        name = gets.strip
        user="Ther is something wrong with signup"
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
            puts "You currently do not have any favorites."
            puts "If you would like to add a new favorite animal, please type 'add' in the main menu."
        else
            puts "------------"
            puts "MY FAVORITES"
            puts "------------"
            self.my_favorites.each do |favorite|
                count = 1
                Animal.all.each do |animal|
                    if animal.id == favorite.animal_id
                        puts "#{count}. #{animal.common_name.capitalize}"
                        puts "Scientific name: #{animal.scientific_name.capitalize}"
                        puts "Conservation status: #{animal.category}."
                        count += 1
                    end  
                end
            end
        end
    end

    def list_animals
        anny= Animal.all.map {|animal| animal.common_name.capitalize}.compact
        current=0
        puts "Here are 10 animals"
        input = nil
        until anny.include?(input) || input == 'exit' do
            test_length = anny[current...current+10].each do |animal|
                puts animal
            end
            current += 10
            input = 'exit' if test_length.length < 10
            puts "Type the name of the animal you would like to add to you favorites."
            puts "Or you can type 'next' to see more animals or type 'exit' to exit."
            input = gets.chomp.downcase if test_length.length >= 10
        end
        input
    end

    def create_favorite
        puts "Please choose one animal, by their common name, from the following list: "
        input = list_animals
        return if input == 'exit' || !input
        name_search(input)
    end

    def remove_animal
        if self.my_favorites.empty?
            puts "You currently do not have any favorites."
            puts "You need to add to your favorites."
        else
            puts "Please choose one animal, by their common name, from the following list:"
            self.see_favorites
            input = gets.chomp.downcase
            animal = Animal.all.find_by(common_name: input)
            animal_to_delete = Favorite.all.find_by(user_id: self.id, animal_id: animal.id)
            animal_to_delete.delete
        end
    end

    def search
        puts "If you would like to find a particular type of animal, type 'animal'."
        puts "If you would like to search by category, type 'category'."
        puts "You may type 'exit' at any time."
        input = ""
        until input == "exit" do
            if input == "animal"
                search_by_animal
            elsif input == "category"
                search_by_category
            end
            search
        end 
    end

    def search_by_animal
        puts "You may type the full name or partial name of the animal you are looking for: "
        input = gets.chomp.downcase
        animal_array = Animal.all.select do |animal|
            if animal.common_name
                animal.common_name.include?(input)
            end
        end
        animal_array.each {|animal| puts animal.common_name.capitalize}
        favoritize_after_search
    end

    def search_by_category
        puts "The available categories are: Vulnerable, Endangered, Critically Endangered, Near threatened, Extinct, Special least concern, Conservation Dependent, Least concern, Extinct in the wild"
        input = gets.chomp.downcase
        category_array = Animal.all.where(category: input)
        category_array.each { |animal| puts animal.common_name.capitalize}
        puts "Would you like to look at the animals in a category?"
        favoritize_after_search
    end

    def favoritize_after_search
        puts "Would you like to add any of these animals to your favorites? (Y/N)"
        input=gets.strip.downcase
        if input=="y"
            puts "Please type the animal that you want to add to your favorites!"
            input=gets.strip.downcase
            name_search(input)
        end
    end

    def name_search(input)
        animal_input = input
        animal = Animal.all.find_by(common_name: animal_input)
        Favorite.find_or_create_by(user_id: self.id, animal_id: animal.id)   
    end

    def self.default_user
        User.create(username: "Unknown-Browser", password: "irosen1234", display_name: "UB")
    end

end