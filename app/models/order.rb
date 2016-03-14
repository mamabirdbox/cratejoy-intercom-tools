class Box < Struct.new(:name, :position)
end
class Order
  attr_accessor :name, :customer_id, :tracking_number
  def initialize json={}
    self.tracking_number = json["tracking_number"]
    self.name = json["customer"]["name"]
    self.customer_id = json["customer_id"]
  end
  def self.boxes
    [
      Box.new("Month 3", 1),
      Box.new("Month 4", 2),
      Box.new("Month 5", 3),
      Box.new("Month 6", 4),
      Box.new("Month 7", 5),
      Box.new("Month 8", 6),
      Box.new("Month 9", 7),
      Box.new("Postpartum 1", 8),
      Box.new("Postpartum 2", 9),
      Box.new("Postpartum 3", 10)
    ]
  end
end
