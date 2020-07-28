require_relative '../config/environment'


cli=Cli.new
cli.welcome
user = cli.startup
cli.turn(user)
