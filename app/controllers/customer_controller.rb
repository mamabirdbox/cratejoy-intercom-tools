class CustomerController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update
  def index
  end
  def update
    customer_hash = params[:customer]
    intercom = ::Intercom::Client.new(app_id: 'doj5flma', api_key: 'e5feac8091f53c4f97b2dab02a6a2dee69db63ff')
    user = intercom.users.find(id: customer_hash[:id])
    user.name = customer_hash[:name]
    user.email = customer_hash[:email]
    user.user_id = customer_hash[:user_id]
    unix_due = customer_hash[:due_date].split("/")
    unix_due = Date.new(unix_due[2], unix_due[0], unix_due[1]).to_time.to_i
    user.custom_attributes["babyduedate"] = unix_due
    intercom.users.save(user)

    redirect_to customer_path
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
    begin
      customer = intercom.users.find(search)
      customer_hash = JSON.parse customer.to_json
      @customer = IntercomCustomer.new(customer_hash)
      respond_to do |format|
        format.html { redirect_to customer_path }
        format.json { render json: @customer.to_json }
      end
    rescue Intercom::MultipleMatchingUsersError
      respond_to do |format|
        format.html { redirect_to customer_path}
        format.json { redirect_to customer_path}
      end
    end
  end
  def retry_intercom
    @customer = Customer.find(params[:id])
    result = @customer.fetch_intercom
    flash[:notice] = result == :ok ? "Customer Updated!" : "Customer not found in intercom"
    redirect_to root_url
  end
end
