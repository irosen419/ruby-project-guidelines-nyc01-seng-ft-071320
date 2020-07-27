class Animal < ActiveRecord::Base
    has_many :favorites
    has_many :users, through: :favorites

    # def self.animals_by_category(category)
    #     animal_array = self.all.result.each do |animal|
    #         animal[:result].select do ||
    #     end
    # end



end