class HomeController < ApplicationController
  def index
    @cratejoy_orders = Order.all
  end
end
