class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :intercom_id

      t.timestamps null: false
    end
  end
end
