class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :restaurant, foreign_key: true
    add_column :orders, :scheduled_time, :datetime
    add_column :orders, :order_type, :integer, null: false, default: 0 # 0: withdrawal , 1: delivery
    add_column :orders, :order_status, :integer, null: false, default: 0 # 0: saved , 1: pending, 2: completed, 3: withdrawn, 4: delivered 
    # Not used:  Will be pulled from Stripe
    # add_column :orders, :paiement_status, :integer, null: false, default: 0 # 0: canceled , 1: paid
  end
end