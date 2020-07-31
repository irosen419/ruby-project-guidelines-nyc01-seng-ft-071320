require_relative '../config/environment'

cli=Cli.new
p cli.runtime

# cli=Cli2.new
# cli.runtime

# menu = ["add       : add an animal to your favorites list","rankings  : view different animal rankings", "update    : make updates to user info", "logout    : logout of current account", "delete    : remove an animal from your favorites", "list      : displays a list of all animals, ten at a time", "favorites : displays your list of favorite animals", "search    : search of new animals to add to your list","exit      : exits this program"].sort_by { |word| word.downcase } 
# convert_hash=menu.map{|x| x.split(" ")[0]}
# hash_menu=Hash[(1...convert_hash.size+1).zip convert_hash]
# input=gets.strip
# hash_key=input.to_i
# p hash_menu[hash_key] if hash_key.between?(1, 9)
# input=gets.strip
# start=["exit","login","log in","sign up","signup","browse","logout","log out"]



# test=""
# binding.pry
#puts "what? What? is two questions."