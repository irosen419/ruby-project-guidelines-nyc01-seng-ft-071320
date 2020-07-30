class Charity < ActiveRecord::Base
    has_many :donations
    has_many :users, through: :donations
<<<<<<< HEAD


    
end
=======
    
    def self.get_charity
        main_url = RestClient.get("https://apps.des.qld.gov.au/species/?op=getorganisations")
        charity_data = JSON.parse(main_url) 
        charity_data["Organisation"].each do |charity_hash|
            Charity.create(name: charity_hash["Name"], acronym: charity_hash["Acronym"], org_type: charity_hash["OrganisationType"])
        end
    end 
    

>>>>>>> origin/master

end
