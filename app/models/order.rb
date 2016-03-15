class Order < ActiveRecord::Base
  belongs_to :box
  belongs_to :customer

  def find_intercom_user
    intercom = ::Intercom::Client.new(app_id: 'doj5flma', api_key: 'e5feac8091f53c4f97b2dab02a6a2dee69db63ff')
    begin
      user = intercom.users.find(user_id: customer.cratejoy_id.to_s)
    rescue ::Intercom::ResourceNotFound
      puts "Couldn't find the user: #{customer.name} - #{customer.cratejoy_id}"
    end
    if user
      "Intercom id: #{user.id}"
    else
      "Couldn't find the user: #{customer.name} - #{customer.cratejoy_id}"
    end
  end
end
