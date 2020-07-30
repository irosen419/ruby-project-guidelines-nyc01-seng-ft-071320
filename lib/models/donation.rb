class Donation < ActiveRecord::Base
    has_many :animals
    belongs_to :user
    belongs_to :charity

    def self.create_donations
        users=User.all
        animals=Animal.all
        charities=Charity.all
        
        users.each do |user|
            3.times do
                animal_count = rand(0..animals.count-1)
                charity_count = rand(0..charities.count-1)
                self.create(amount: rand(1..1000), memo: "For ALL the animals!" , user_id: user.id, charity_id: Charity.all[charity_count].id, animal_id: Animal.all[animal_count].id)
            end
        end
    end
end