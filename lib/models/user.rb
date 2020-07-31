class User < ActiveRecord::Base
    has_many :favorites
    has_many :animals, through: :favorites
    has_many :donations
    has_many :charities, through: :donations

    include Art::InstanceMethods
    
    def my_favorites
        Favorite.all.where(user_id: self.id)
    end

    def see_favorites
        if self.my_favorites.empty?
            puts "You currently do not have any favorites.\nIf you would like to add a new favorite animal, please type 'add' in the main menu.\n"
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
                puts "\nType 'exit' if you would like to exit or any key to see more favorites."
                input = gets.chomp.downcase if show_length.length >= 5
            end
        end
        input
    end

    def list_animals 
        anny= Animal.all.map {|animal| animal.common_name}.shuffle
        current=0
        puts "\nHere are 10 animals"
        input = nil
        until anny.include?(input) || input == 'exit' do
            test_length = anny[current...current+10].each do |animal|
                puts animal.capitalize
            end
            current += 10
            input = 'exit' if test_length.length < 10
            puts "\nType 'next' to see more animals,\nor type 'exit' to exit.\n" if test_length.length == 10
            puts "\nYou have reached the end of the list. \nAny input will lead you back to the main screen\n" if test_length.length < 10 
            input = gets.chomp.downcase if test_length.length >= 10
            sleep(0.75)
            input
        end
        input
    end

    def create_favorite
        puts "\nPlease choose one animal, by their common name, from the following list: "
        input = list_animals
        return if input == 'exit' || !input
        name_search(input)
    end

    def remove_animal
        if self.my_favorites.empty?
            puts "You have no favorites. You could use an animal to love!"
        else 
            puts "\nPlease choose one animal, by their common name, from the following list:"
            count = 1
            hash_anny = {}
            self.my_favorites.each do |favorite|
                Animal.all.each do |animal|
                if animal.id == favorite.animal_id
                    hash_anny[count]= "#{animal.common_name.capitalize} | Scientific name: #{animal.scientific_name.capitalize} | Conservation status: #{animal.category.capitalize}."#\n"
                        count += 1
                    end 
                end
            end
            hash_anny.each {|k,v| puts "#{k}. #{v}" }
            input = gets.strip.downcase
            sleep(0.75)
            animal = Animal.all.find_by(common_name: input)
            if animal ==nil || input == "exit"
                puts "You have chosen to 'exit from this screen.\nThank you for leaving these poor animals alone." if input == "exit"
                puts "You must have made a typo.\nMaybe no animal wants to leave your list" if animal ==nil
            elsif animal 
                puts "You have deleted #{input} from your favorites.\n#{input} is very sad to be deleted from your list.\nI hope you are happy with yourself.\n"
                sleep(0.75)
                animal_to_delete = Favorite.all.find_by(user_id: self.id, animal_id: animal.id)
                animal_to_delete = animal_to_delete.delete
            end
        end 
    end
    
    def search
        input=""
        until input == "exit" do
            search_by_animal if input == "animal"
            search_by_category if input == "category"
            input = search_instructions
        end
        puts "Thank you for searching!"
    end

    def search_by_animal
        puts "\nYou may type the full name or partial name of the animal you are looking for: "
        animal_input = gets.chomp.downcase
        sleep(0.75)
        puts "\n"
        animal_array = Animal.all.select do |animal|
            animal.common_name.include?(animal_input)
        end
        if animal_array.length > 0
            animal_array.each {|animal| puts animal.common_name.capitalize}
            favoritize_after_search
        elsif animal_array.length == 0
            puts "\nSorry, there are no threatened #{animal_input.pluralize} in Australia. Please try again.\n\n"
        end
    end

    def search_by_category
        puts "\nThe available categories are: Vulnerable, Endangered, Critically Endangered, Near threatened, Extinct, Special least concern, Conservation Dependent, Least concern, Extinct in the wild"
        puts "Which category would you like to view?"
        input = gets.chomp.downcase
        sleep(0.75)
        category_array = Animal.all.where(category: input)
        category_array.each { |animal| puts animal.common_name.capitalize}
        favoritize_after_search
    end  

    def favoritize_after_search
        puts "\nPlease type the animal that you want to add to your favorites."
        input=gets.chomp.downcase
        sleep(0.75)
        until input == "exit"
            search = name_search(input)
            puts "\nYou have added #{input.capitalize} to your favorites!\n" if search != nil #FS version needs to be taken out if we still want this to be implemented
            input = "exit"
        end
    end

    def name_search(input)
        animal_input = input
        animal = Animal.all.find_by(common_name: animal_input)
        Favorite.find_or_create_by(user_id: self.id, animal_id: animal.id) if animal 
        puts "\nYou have added #{input.capitalize} to your favorites!\n" if animal #James added this line Thursday for the added animal feature. 
        puts "\nYou might have mispelled that name. Please try again.\n" if !animal #Live above might be duplicated by favoritize, we might have to remove that line
    end
    
    def change_user_info
        puts "    You can make the following changes to your account"
        menu = ["password     : update your password", "delete       : delete your account", "username     : update your username", "display name : update your display name", "exit         : return to the main menu"].sort_by { |word| word.downcase }    
        menu.each{|item|puts "- #{item}"}
        input = gets.strip.downcase
        sleep(0.75)
        if input == "username"
            puts "Please type in your new username:"
            name_input = gets.strip
            sleep(0.75)
                self.update(username: name_input)
        elsif input == "password"
            puts "Please type in your new password:"
            password_input = gets.strip
            sleep(0.75)
                self.update(password: password_input)
        elsif input == "display name"
            puts "Please type in your new display name:"
            display_input = gets.strip
            sleep(0.75)
                self.update(display_name: display_input)
        elsif input == "delete"
            puts "Are you sure you want to delete your account? If so, please type [Y]. You can enter any key to return to the main menu."
            delete_input = gets.strip
            sleep(0.75)
            delete_input
                if delete_input.downcase == "y"
                    self.delete
                    puts "Your account is deleted. You will still be able to browse our app as a Guest."
                    input = "logout"
                end
        end
        input
    end

    def self.default_user
        User.create(username: "Unknown-Browser", password: "irosen1234", display_name: "Guest")
    end

    def top
        input = top_instructions
        Animal.lonely_animals if input == "sad"
        Animal.top_five if input == "top"
    end

    def donation_page
        input=""
        until input == "exit" do
            make_a_donation if input == "donate"
            list_charities if input == "list"
            list_my_donations if input =="view"
            top_donors if input == "rankings"
            my_donations if input =="donations"
            input = donation_instructions
        end
        puts "Thank you for Donation or your Consideration.\nPlease consider donating to these poor animals again!\n"
    end

    def make_a_donation
        puts "Please choose a charity to donate to: "
        charity = choose_charity
        puts "Please choose an animal to donate in honor of: "
        animal = choose_animal
        puts "Please write a memo to describe your donation: "
        memo = gets.chomp
        sleep(0.75)
        puts"Finally, please denote an amount for the donation: "
        amount = gets.chomp
        sleep(0.75)
        Donation.create(amount: amount.to_i, memo: memo, user_id: self.id, charity_id: charity.id, animal_id: animal.id)
        puts "Your donations are: "
        list_my_donations
        puts "\n\nYou have donated a total of $#{my_donation_total[:amount]}."
    end

    def choose_charity
        list_charities
        input = gets.chomp.downcase
        sleep(0.75)
        Charity.all.find_by(name: input)
    end

    def list_charities 
        Charity.all.each do |char|
            puts char.name.capitalize
        end
    end

    def choose_animal
        list_animals
        puts "Now please enter the animal name: "
        input = gets.chomp.downcase
        sleep(0.75)
        Animal.all.find_by(common_name: input)
    end
    
    def my_donations
        Donation.all.where(user_id: self.id)
    end

    def list_my_donations 
        non_acronym_array = []
        if self.my_donations.length == 0 || self.my_donations == nil
            puts "\n\nYou have not made any donations. You should get on that!"
        else
            self.my_donations.each do |donation|
                charity_id = donation.charity_id
                charity = Charity.find(charity_id)
                animal_id = donation.animal_id
                animal = Animal.find(animal_id)
                if charity.acronym
                    puts "\nCharity name: #{charity.name.capitalize}(#{charity.acronym}), Donation amount: $#{donation.amount}, In honor of: #{animal.common_name.pluralize.capitalize}."
                else
                    non_acronym_array << "Charity name: #{charity.name.capitalize}, Donation amount: $#{donation.amount}, In honor of: #{animal.common_name.pluralize.capitalize}."
                end
            end
            non_acronym_array.each {|charity_string| puts charity_string}
        end
    end

    def my_top_donations
        my_donations.max_by(5) {|donation| donation.amount}
    end

    def my_donation_total
        total = my_donations.sum {|donation| donation.amount}
        self.display_name ? {name: self.display_name, amount: total} : {name: self.username, amount: total}
    end

    def top_donors
        hashes = User.all.map {|user| user.my_donation_total}.max_by(5) {|key| key[:amount]}
        counter = 1
        hashes.each do |hash|
            puts "#{counter}. #{hash[:name]}: $#{hash[:amount]}"
            counter += 1
        end
    end

end