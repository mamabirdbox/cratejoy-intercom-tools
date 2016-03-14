class Order
  attr_accessor :name, :customer_id, :tracking_number
  def initialize json={}
    self.tracking_number = json["tracking_number"]
    self.name = json["customer"]["name"]
    self.customer_id = json["customer_id"]
  end
end
