class OrderController < ApplicationController
  def update
    @order = Order.find(params[:id])
    if @order
      box = Box.find(params[:order][:box_id])
      @order.update_attributes(box: box)
      @order.update_intercom(box)
    end
    redirect_to root_path
  end
end
