class OrderController < ApplicationController
  def update
    @order = Order.find(params[:id])
    if @order
     box = Box.find(params[:order][:box_id])
     local_ok = @order.update_attributes(box: box)
     intercom_ok = @order.update_intercom(box)
     if local_ok && intercom_ok
       state = :ok
     else
       state = :error
     end
    else
      state = :error
    end
    respond_to do |format|
      format.html { redirect_to root_path}
      format.json { render json: {status: state}.to_json }
    end
  end

  def manual_update
    CrateJoy::API.build_from_date(params[:date])
    redirect_to root_url
  end
end
