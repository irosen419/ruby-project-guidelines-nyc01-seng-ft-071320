class Donation < ActiveRecord::Base
    belongs_to :user
    belongs_to :charity

    def self.create_donation
        users=Users.all
    end

end