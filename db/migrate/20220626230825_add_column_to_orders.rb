class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :invoice_url, :string, default: "", null: false
  end
end
