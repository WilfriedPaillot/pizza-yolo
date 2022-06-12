class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :reference
      t.decimal :total, precision: 7, scale: 2

      t.timestamps
    end
  end
end
