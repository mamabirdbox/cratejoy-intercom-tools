class Order < ActiveRecord::Base
  belongs_to :box
  belongs_to :customer

end
