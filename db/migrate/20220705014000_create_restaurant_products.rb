class CreateRestaurantProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_products do |t|
      t.references :restaurant, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
