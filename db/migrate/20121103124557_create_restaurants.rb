class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :hebrew_name
      t.string :english_name
      t.string :logo
      t.integer :cp_id
      t.integer :counter
      t.datetime :last_announcement
      t.timestamps
    end
  end
end
