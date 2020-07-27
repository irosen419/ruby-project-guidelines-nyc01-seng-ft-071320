require_relative '../config/environment'



# puts "HELLO WORLD"
cli=Cli.new
cli.welcome
user = cli.startup
cli.turn(user)
# puts "hi its jenn?"
# puts "Hola, Can we call you Jenn"
