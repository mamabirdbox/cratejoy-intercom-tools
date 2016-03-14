class HomeController < ApplicationController
  def index
    @cratejoy_orders = CrateJoy.orders
  end
end
