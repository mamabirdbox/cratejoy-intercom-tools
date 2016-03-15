class Customer < ActiveRecord::Base
  has_many :orders
  after_create :fetch_intercom

  def self.states
    {unchecked: "unchecked", connected: "connected", not_found: "not found"}
  end

  def fetch_intercom
    result = :error
    if user
      update_attributes({intercom_status: Customer.states[:connected], intercom_id: user.id})
      result = :ok
    end
    result
  end

  def find_intercom_user
    intercom = ::Intercom::Client.new(app_id: 'doj5flma', api_key: 'e5feac8091f53c4f97b2dab02a6a2dee69db63ff')
    begin
      user = intercom.users.find(user_id: cratejoy_id.to_s)
    rescue ::Intercom::ResourceNotFound
      begin
        user = intercom.users.find(email: email)
        user.user_id = cratejoy_id.to_s
        intercom.users.save(user)
      rescue ::Intercom::ResourceNotFound
        update_attributes intercom_status: Customer.states[:not_found]
      end
    end
    user
  end

end
