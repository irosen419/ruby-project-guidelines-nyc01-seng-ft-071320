class Charity < ActiveRecord::Base
    has_many :donations
    has_many :users, through: :donations
end