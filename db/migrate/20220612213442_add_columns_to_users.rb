class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, null: false, default: 0
    add_column :users, :firstname, :string, default: ''
    add_column :users, :lastname, :string, default: ''
    add_column :users, :address, :string, default: ''
    add_column :users, :zipcode, :string, default: ''
    add_column :users, :city, :string, default: ''
    add_column :users, :phone, :string, default: ''
  end
end
