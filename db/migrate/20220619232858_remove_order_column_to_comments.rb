class RemoveOrderColumnToComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :order_id
    remove_index :comments, name: "index_orders_on_user_id"
  end
end
