class AddAnimalColumnToDonations < ActiveRecord::Migration[6.0]
  def change
    add_column :donations, :animal_id, :integer
  end
end
