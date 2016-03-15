class CustomerController < ApplicationController
  def retry_intercom
    @customer = Customer.find(params[:id])
    result = @customer.fetch_intercom
    flash[:notice] = result == :ok ? "Customer Updated!" : "Customer not found in intercom"
    redirect_to root_url
  end
end
