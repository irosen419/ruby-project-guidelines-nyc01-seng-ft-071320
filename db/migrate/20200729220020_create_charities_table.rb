class CreateCharitiesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :charities do |t|
      t.string :name
      t.string :acronym
      t.string :org_type
    end
  end
end
