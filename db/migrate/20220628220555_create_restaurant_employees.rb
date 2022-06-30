class CreateRestaurantEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_employees do |t|
      t.references :restaurant, foreign_key: true
      t.references :employee, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
