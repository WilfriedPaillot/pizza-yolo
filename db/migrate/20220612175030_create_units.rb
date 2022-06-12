class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.string :tag, null: false

      t.timestamps
    end
  end
end
