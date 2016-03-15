class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :intercom_status, default: 'unchecked'
      t.integer :intercom_id
      t.integer :cratejoy_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end
    remove_column :orders, :customer_id
    add_reference :orders, :customer, index: true
  end
end
