class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    # add_column :users, :selected_restaurant_id, :integer, null: true
    add_reference :users, :restaurant, foreign_key: true, null: true
  end
end
