class Favorite < ActiveRecord::Base
    belongs_to :animal
    belongs_to :user

    include Art::InstanceMethods
    # self.create_donation

    def self.create_favs
        names
        users=[]
        animal_num=Animal.all.count
        names.each do |person| 
            users<<User.create(username: person.downcase, password: 1234, display_name: "user_#{person}")
        end
        users.each do |u|
            10.times do 
                annie= rand(1..animal_num)
            Favorite.create(user_id: u.id, animal_id: annie)
            end
        end
    end

    # User.create(username: "Brian", password: 1234, display_name: "Lego")
    # Favorite.create(user_id: User.all[0].id, animal_id: Animal.all[0].id)

end