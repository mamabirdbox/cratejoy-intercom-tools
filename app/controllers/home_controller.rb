class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @cratejoy_orders = Order.with_updates_needed
  end
end
