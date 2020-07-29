module Art
    module InstanceMethods
        def welcome2
            puts "                                                "
            puts "______FAVORITE_AUS_ENDANGERED_ANIMALS___________" 
            puts "                                                "
            puts "         _By: Jennifer Yoo,                     "
            puts "        / /         Ian Rosen,                  "
            puts "        '. \\               James Wu            "
            puts "         '- \\                  @Class of       "
            puts "          / /_         .---.           13JUL    "
            puts "         / |,.\\/--.//    )                     "
            puts "         |  \\//        )/  /                   "
            puts "   Art    \\ ' ^ ^    /    )____.----..   6     "
            puts "  by       '.____.    .___/            \\._)    "
            puts "   Morfina   .\/.                      ).       "
            puts "               '\\                      /       "
            puts "               _/\\/    ).        )    (        "
            puts "              /#  .!    |        /\\   /        "
            puts "             \\  C/ #  /'-----''/ #  /          "
            puts "           .  \\ 'C/ |    |    |   |  |      ,  "
            puts "          \\),/ .. .'OOO-'. ..'OOO'OOO-'. ..\\(,"
            puts "________________________________________________" 
            puts "__________Please_SIGNUP_up_or_LOGIN_____________"
            puts "__________Or_type_BROWSE_to_check_us_out________"
        end

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
        puts"SIGNUP-OR-LOGIN----"
        puts"---------OR-BROWSE-"
        end

        def goodbye
            puts "We are sorry to see you go!"
            puts "                     .    "
            puts "                    / V\\ "
            puts "                  / `  /  "
            puts "                 <<   |   "
            puts "                 /    |   "
            puts "               /      |   "
            puts "             /        |   "
            puts "           /    \\  \\ /  "
            puts "          (      ) | |    "
            puts "  ________|   _/_  | |    "
            puts "<__________\\______)\\__) "
            "     Please come back again!   "
        end

        def help
            puts "  I can accept the following commands"
            menu = ["logout    : logout of current account", "delete    : remove an animal from your favorites","help      : displays this help message", "list      : displays a list of all animals, ten at a time", "favorites : displays your list of favorite animals", "search    : search of new animals to add to your list","exit      : exits this program"].sort_by { |word| word.downcase }
            menu.each{|item|puts "- #{item}"}
        end

        def login_fail
            puts "your username or password is incorrect"
            puts "Please type sign up, login, or browse"
        end

    end
end
