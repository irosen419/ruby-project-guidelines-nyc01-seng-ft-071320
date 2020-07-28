class User < ActiveRecord::Base
    has_many :favorites
    has_many :animals, through: :favorites

    def self.login
        puts "Welcome Back! What is your Username?"
        puts "Log in see the status of your favorite animals." 
        name = gets.chomp
        if User.find_by(username: name)
            puts "What is your password?"
            password = gets.chomp
if password != 
            user = User.find_by(username: name, password: password)
            end
        end
    end#if user signs in correctly, then user is used in CLI APP. 
        #if no user, then this will trigger CLI to relaunch

    def self.sign_up
        puts "Please enter your username."
        name = gets.chomp
        puts "Enter a password."
        password = gets.chomp
        user = User.find_or_create_by(username: name, password: password, display_name: nil)
        puts "Would you like a nickname that we can address as? (Y/N)"
        input = gets.chomp
        if input.downcase == "y"
            puts "What would you like that name to be?"
            name_input = gets.chomp
            puts "Great. Thanks, #{name_input}!"
            user.display_name = name_input
        else
            puts "Okay, no worries!"
        end
    end
        
    def my_favorites
        Favorite.where(user_id: self.id) 
    end

    def see_favorites
        self.my_favorites.each do |favorite|
           Animal.all.each do |animal|
            if animal.id == favorite.animal_id
                puts "#{animal.common_name}, also known as #{animal.scientific_name}, is considered #{animal.category}."
            end
           end
        end
    end

    def create_favorite
        puts "Please choose one animal, by their common name, from the following list:"
        Animal.all.each {|animal| puts animal.common_name}
        animal_input = gets.chomp
        animal = Animal.all.find_by(common_name: animal_input)
        Favorite.find_or_create_by(user_id: self.id, animal_id: animal.id)  
    end

    def delete_animal
        puts "Please choose one animal, by their common name, from the following list:"
        self.my_favorites
        input = gets.chomp
        animal = Animal.all.find_by(common_name: input)
        animal.delete
    end

    def update_user
    end

end