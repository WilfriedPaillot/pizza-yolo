class RemoveReferencesToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :products, :restaurant, index: true, foreign_key: true
  end
end
