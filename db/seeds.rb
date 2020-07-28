require 'rest-client'
require 'json'
require 'pry'
# require '../lib/models/cli.rb'

User.delete_all
Animal.delete_all
Favorite.delete_all

#http://apps.des.qld.gov.au/species/?op=getclassnames&kingdom=animals #Main Link

Animal.get_database_animals_gov_au

User.create(username: "Ian", password: 1234, display_name: "E")
User.create(username: "James", password: 1234, display_name: nil)
User.create(username: "jennyoyo", password: 1234, display_name: "jenn")
User.create(username: "Tashawn", password: 1234, display_name: nil)
User.create(username: "Ian G", password: 1234, display_name: nil)
User.create(username: "Ryan W", password: 1234, display_name: nil)
User.create(username: "Cody", password: 1234, display_name: nil)
User.create(username: "Cody", password: 1234, display_name: "Cody.NYC")
User.create(username: "Ryan", password: 1234, display_name: nil)
User.create(username: "Brian", password: 1234, display_name: "Lego")

Favorite.create(user_id: User.all[1].id, animal_id: Animal.all[1].id)
Favorite.create(user_id: User.all[2].id, animal_id: Animal.all[2].id)
Favorite.create(user_id: User.all[3].id, animal_id: Animal.all[4].id)
Favorite.create(user_id: User.all[1].id, animal_id: Animal.all[4].id)
Favorite.create(user_id: User.all[2].id, animal_id: Animal.all[5].id)
Favorite.create(user_id: User.all[3].id, animal_id: Animal.all[6].id)
Favorite.create(user_id: User.all[1].id, animal_id: Animal.all[7].id)
Favorite.create(user_id: User.all[2].id, animal_id: Animal.all[7].id)
Favorite.create(user_id: User.all[3].id, animal_id: Animal.all[7].id)