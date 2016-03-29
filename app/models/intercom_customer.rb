class IntercomCustomer < Struct.new(:due_date, :name, :email, :user_id, :id)

  def initialize(intercom_hash)
    self.due_date = intercom_hash["custom_attributes"]["babyduedate"]
    self.name = intercom_hash["name"]
    self.email = intercom_hash["email"]
    self.user_id = intercom_hash["user_id"]
    self.id = intercom_hash["id"]
  end

end
