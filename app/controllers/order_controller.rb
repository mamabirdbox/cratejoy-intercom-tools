class OrderController < ApplicationController
  def update
    @order = Order.find(params[:id])
    if @order
      @order.update_attributes(box: Box.find(params[:order][:box_id]))
    end
    redirect_to root_path
  end
end
