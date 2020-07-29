class CreateDonationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.string :memo
      t.integer :user_id
      t.integer :charity_id
    end
  end
end
