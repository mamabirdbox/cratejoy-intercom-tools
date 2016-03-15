class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.integer :customer_id, null: false
      t.string :tracking_number
      t.integer :cratejoy_id, null: false
      t.references :box, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
