module Art
    module InstanceMethods

        def welcome
        puts"\n\n  DONATION NATION:  "
        puts"     AUSTRALIA      "
        puts"          |   | //##"
        puts"    n___n |   |//   "
        puts"  ._\\'O'/___   /   "
        puts"  ['o']  ___: |     "
        puts"  /  ,-': |_  |     "
        puts"  \\_,./__,__: |    "
        puts"          |   |     "
        puts"          |   |     "
        puts"SIGNUP OR LOGIN     "
        puts"         OR BROWSE  "
        end

        def goodbye
        puts "\n\n  We are sorry to see you go!  "
        puts "     Art by Joan G. Stark       "
        puts "            |\\._                "
        puts "            |  o o__             "
        puts "             \\   _.3            "
        puts "        ,    `) (               "
        puts "        )\\   /__\\__            "
        puts "       / /  / -._);_)           "
        puts "      |  `\\/  \ __|\            "
        puts "       \\  ;    ) / )           "
        puts "       `\\|   /__/ /__          "
        puts "     jgs `\\______)___)         "
        puts "   Please come back again!      "
        end

        def instructions
            puts "\n            ----- MAIN MENU -----   \n      I can accept the following commands\n"
            menu = ["donate    : go to the donation menu","add       : add an animal to your favorites list","rankings  : view different animal rankings", "update    : make updates to user info", "logout    : logout of current account and go back to the welcome screen", "delete    : remove an animal from your favorites", "list      : displays a list of all animals, ten at a time", "favorites : displays your list of favorite animals", "search    : search of new animals to add to your list"].sort_by { |word| word.downcase } 
            menu.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
            puts "You may type 'exit' at any time."
            convert_hash=menu.map{|x| x.split(" ")[0]}
            hash_menu=Hash[(1...convert_hash.size+1).zip convert_hash]
            input = gets.strip.downcase
            hash_key=input.to_i
            input = hash_menu[hash_key] if hash_key.between?(1, 9)            
            puts "\n"
            input
        end 
        
        def login_fail
            puts "Your username or password is incorrect.\nPlease type sign up, login, or browse"
        end

    end
end

def top_instructions
    puts"Type 'top' to see the Top 5 most popular animals.\nType 'sad' to see 5 lonely animals who have not yet been favorited."
    input = gets.chomp.downcase
    sleep(0.75)
    input
end

def search_instructions
    puts "                   ----- SEARCH MENU -----                             \nIf you would like to find a particular type of animal, type 'animal'. \n If you would like to search by category, type 'category'.\n You may type 'exit' at any time."
    input = gets.chomp.downcase
    sleep(0.75)
    input
end

def donation_instructions
    puts "\n\n                   ----- DONATION MENU -----                             "
    donations_menu = ["rankings  : view top donors","donate    : donate to a charity of your choice","list      : look at the available charities","view      : review all your donations"].sort_by { |word| word.downcase } 
    donations_menu.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
    puts "Welcome to the Donation Page.\nYou may type 'exit' at any time."
    convert_hash=donations_menu.map{|x| x.split(" ")[0]}
    hash_menu=Hash[(1...convert_hash.size+1).zip convert_hash]
    input = gets.strip.downcase
    sleep(0.75)
    hash_key=input.to_i
    input = hash_menu[hash_key] if hash_key.between?(1, donations_menu.count) 
    input
end 

def names
    names= "Tashawn,IanG,James,IanR,Jennifer,Alex,Junko,RyanW,Karan,SeMin,JakeL,Brian,Devin,Muhtasim,Josh,DavidKir,Amit,JakeM,Victor,Kevin,RyanF,Vincent,DavidK,Ward,Codyd,RyanL,Matthew,Gregory,Codyc,Mimi,Minelie,Joseph,Samuel,Sawandi,Iuri,Jzavier,Israel,Vlad,Teddy"
    names =names.split(",")
end

def logout_talk(user)                                                                  
    input ="logout"
    puts"Would you like to save your favorites by creating a new account (Y/N)"
    user_input=gets.strip
    sleep(0.75)
    input = "logout"                                         
end
#we need to implement a message when they logout using a browsing user that they will
#need to create an account to save their favorites list. if they type create (should we 
#let them use the update account function to upate their account information or should we 
#just have them go through the signup process and transfer their favorites to the new 
#account that they have created)