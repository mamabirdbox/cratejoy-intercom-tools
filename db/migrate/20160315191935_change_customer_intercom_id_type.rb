class ChangeCustomerIntercomIdType < ActiveRecord::Migration
  def change
    change_column :customers, :intercom_id, :string
  end
end
