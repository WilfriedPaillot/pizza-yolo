class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :adress, null: false
      t.string :zipcode, null: false
      t.string :city, null: false
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
