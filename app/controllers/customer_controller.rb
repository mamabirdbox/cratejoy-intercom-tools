class CustomerController < ApplicationController
  def index
  end
  def search
    query = params[:query]
    if query.include? "@"
      search = {email: query}
    elsif query.length < 20
      search = {user_id: query}
    else
      search = {id: query}
    end
    intercom = ::Intercom::Client.new(app_id: 'doj5flma', api_key: 'e5feac8091f53c4f97b2dab02a6a2dee69db63ff')
    customer = intercom.users.find(search)
    customer_hash = JSON.parse customer.to_json
    @customer = IntercomCustomer.new(customer_hash)
    respond_to do |format|
      format.html { redirect_to root_path}
      format.json { render json: @customer.to_json }
    end
  end
  def retry_intercom
    @customer = Customer.find(params[:id])
    result = @customer.fetch_intercom
    flash[:notice] = result == :ok ? "Customer Updated!" : "Customer not found in intercom"
    redirect_to root_url
  end
end
