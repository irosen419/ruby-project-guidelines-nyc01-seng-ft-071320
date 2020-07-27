class CreateAnimalsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.string :scientific_name
      t.string :common_name
      t.string :category
    end
  end
end
