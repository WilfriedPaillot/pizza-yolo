class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 5, scale: 2
      t.string :image_url

      t.timestamps
    end
  end
end
