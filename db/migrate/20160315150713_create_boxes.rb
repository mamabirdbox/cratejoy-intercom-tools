class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.integer :position, null: false

      t.timestamps null: false
    end
    add_index :boxes, :position, unique: true
  end
end
