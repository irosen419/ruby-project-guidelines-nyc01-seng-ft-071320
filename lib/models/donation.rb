class Donation < ActiveRecord::Base
    has_many :animals
    belongs_to :user
    belongs_to :charity
end