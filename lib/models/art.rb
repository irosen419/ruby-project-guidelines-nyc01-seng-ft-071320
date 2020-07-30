module Art
    module InstanceMethods

        def welcome
        puts"  DONATION NATION:  "
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
        puts "   We are sorry to see you go!  "
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
             "   Please come back again!      "
        end

        def instructions
            puts "            ----- MAIN MENU -----   \n"
            puts "      I can accept the following commands"
            menu = ["donate    : exits this program","add       : add an animal to your favorites list","rankings  : view different animal rankings", "update    : make updates to user info", "logout    : logout of current account", "delete    : remove an animal from your favorites", "list      : displays a list of all animals, ten at a time", "favorites : displays your list of favorite animals", "search    : search of new animals to add to your list"].sort_by { |word| word.downcase } 
            menu.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
            puts "You may type 'exit' at any time."
            convert_hash=menu.map{|x| x.split(" ")[0]}
            hash_menu=Hash[(1...convert_hash.size+1).zip convert_hash]
            input = gets.strip.downcase
            hash_key=input.to_i
            input = hash_menu[hash_key] if hash_key.between?(1, 9)            
            # "Please use type 'exit' to exit or go back" #if we add donate then we need to un-hash this line and add it to our list above. We also need to update our function in menu
            puts "\n"
            # binding.pry
            input
        end 
        #trying to implement numbers with instructions 

        def login_fail
            puts "Your username or password is incorrect.\nPlease type sign up, login, or browse"
        end

    end
end

def top_instructions
    puts"Type 'top' to see the Top 5 most popular animals.\nType 'sad' to see the Top 5 most sad animals"
    gets.chomp.downcase
end

def search_instructions
    puts "                   ----- SEARCH MENU -----                             "
    puts "If you would like to find a particular type of animal, type 'animal'. \n If you would like to search by category, type 'category'.\n You may type 'exit' at any time."
    gets.chomp.downcase
end

def donation_instructions
    puts "                   ----- Donation MENU -----                             "
    donations_menu = ["donate    : donate to a charity of your choice","list      : look at the available charities","view      : review all your donations"].sort_by { |word| word.downcase } 
    donations_menu.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
    convert_hash=donations_menu.map{|x| x.split(" ")[0]}
    hash_menu=Hash[(1...convert_hash.size+1).zip convert_hash]
    input = gets.strip.downcase
    hash_key=input.to_i
    input = hash_menu[hash_key] if hash_key.between?(1, 3) 
    puts "Welcome to the Donation Page." 
    puts "You may type 'exit' at any time.\n"
    input
end 
# "charity   : to look "
# "find      : find a particular "

def no_favorites 
    puts "You currently do not have any favorites.\nIf you would like to add a new favorite animal, please type 'add' in the main menu.\n"
end

def names
    names= "Tashawn Williams,Ian Grubb,James wu,Ian Rosen,Jennifer Yoo,Alex Beciana,Junko Tahara,Ryan Werner,Karan S. Chauhan,Se Min Lee,Jake lozano,Brian Lego,Devin Benson,Muhtasim Ferdous,Josh Allen,David Kirsch,Amit Deshpande,Jake Mills,Victor Scholz,Kevin Xie,Ryan Flynn,Vincent Yang,David Kim,Ward Price,Cody DeMartin,Ryan Locascio,Matthew Peters,Gregory A.S. Wright,Cody C,Mimi Ojserkis,Mineliegoma,Joseph Kofler,Samuel Lesser,Sawandi Wilson,Iuriseara,Jzavier Timm,Israel Canessa,Vladilen Napuri,Teddy Bradsher"
    names =names.split(",")
end

def message_board (array)
    puts ""
end

def logout_talk(user)                                                                  
    input ="logout"
    puts"Would you like to save your favorites by creating a new account (Y/N)"
    
    user_input=gets.strip
    input = "logout"                                         
end
#we need to implement a message when they logout using a browsing user that they will
#need to create an account to save their favorites list. if they type create (should we 
#let them use the update account function to upate their account information or should we 
#just have them go through the signup process and transfer their favorites to the new 
#account that they have created)