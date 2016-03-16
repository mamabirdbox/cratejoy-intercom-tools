class Order < ActiveRecord::Base
  belongs_to :box
  belongs_to :customer

  def self.with_updates_needed
    where(box: nil).order(:shipment_created_at)
  end

  def update_intercom(box)
    intercom = ::Intercom::Client.new(app_id: 'doj5flma', api_key: 'e5feac8091f53c4f97b2dab02a6a2dee69db63ff')
    underscored_box_name = box.name.split(' ').join('_')
    timestamp = shipment_created_at.to_time.to_i.to_i
    intercom_user = customer.find_intercom_user

    intercom_user.custom_attributes["shipped_#{underscored_box_name}_box"] = true
    intercom_user.custom_attributes["shipped_#{underscored_box_name}_date"] = timestamp
    intercom_user.custom_attributes["shipped_#{underscored_box_name}_tracking"] = tracking_number
    intercom.users.save(intercom_user)

    intercom.notes.create(body: "<p> Shipped #{box.name} on #{Date.today}</p>", email: customer.email)
  end
end
