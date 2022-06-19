class AddReferencesToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_reference :ingredients, :unit, foreign_key: true
  end
end
