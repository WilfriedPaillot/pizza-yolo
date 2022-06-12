class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :quote, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
