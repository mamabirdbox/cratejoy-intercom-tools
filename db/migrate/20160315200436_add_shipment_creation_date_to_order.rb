class AddShipmentCreationDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shipment_created_at, :date
  end
end
