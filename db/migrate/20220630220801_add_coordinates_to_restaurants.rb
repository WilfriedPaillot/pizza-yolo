class AddCoordinatesToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :longitude, :float
    add_column :restaurants, :latitude, :float
  end
end
