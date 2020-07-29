module Art
    module InstanceMethods

        def welcome
        puts"  FAVORITE AUSSIE  "
        puts"     ANIMALS       "
        puts"          |   |//## "
        puts"    n___n |   |//   "
        puts"  ._\\'O'/___   /   "
        puts"  ['o']  ___: |    "
        puts"  /  ,-': |_  |    "
        puts"  \\_,./__,__: |   "
        puts"          |   |    "
        puts"          |   |    "
        puts"SIGNUP OR LOGIN    "
        puts"         OR BROWSE "
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

        def help
            puts "      I can accept the following commands"
            menu = ["rankings  : view different animal rankings", "update    : make updates to user info", "logout    : logout of current account", "delete    : remove an animal from your favorites", "list      : displays a list of all animals, ten at a time", "favorites : displays your list of favorite animals", "search    : search of new animals to add to your list","exit      : exits this program"].sort_by { |word| word.downcase }
            menu.each_with_index {|item, index| puts "#{index + 1}. #{item}"}

            puts "\n"
        end
        
        def instructions
            puts "            ----- MAIN MENU -----   "
            puts "\n"
            help
            gets.chomp.downcase
        end 

        def login_fail
            puts "Your username or password is incorrect"
            puts "Please type sign up, login, or browse"
        end

    end
end

def top_instructions
    puts"Type 'top' to see the Top 5 most popular animals"
    puts"Type 'sad' to see the Top 5 most sad animals"
    gets.chomp.downcase
end

def search_instructions
    puts "                   ----- SEARCH MENU -----                             "
    puts "If you would like to find a particular type of animal, type 'animal'."
    puts "If you would like to search by category, type 'category'."
    puts "You may type 'exit' at any time."
    gets.chomp.downcase
end

def no_favorites 
    puts "You currently do not have any favorites."
    puts "If you would like to add a new favorite animal, please type 'add' in the main menu."
end


def message_board (array)
    puts ""
end

#########TESTING##########