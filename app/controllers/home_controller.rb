class HomeController < ApplicationController
  def index
    @cratejoy_orders = Order.with_updates_needed
  end
end
