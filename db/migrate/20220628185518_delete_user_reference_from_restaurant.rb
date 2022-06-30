class DeleteUserReferenceFromRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_reference :restaurants, :user, index: true, foreign_key: true
  end
end
