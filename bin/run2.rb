require_relative '../config/environment'

cli=Clie.new
# cli.welcome

# user= User.find_by(username: "James ")
# p user.password
# p User.sign_up
# p User.login.is_a?User
# p cli.startup
cli.welcome2
cli.goodbye2
#***********chomp leaves a trailing space*********
# j1= "James "
# p j1= j1.chomp #leaves the space
# p j2= j1.strip #just the value