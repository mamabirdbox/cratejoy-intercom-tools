module CrateJoy

  def self.orders
    API.orders
  end

  class API
    def self.response
      if Rails.env.development? || ENV['USE_FAKE_DATA'] == 'yes'
        MockResponseData.response
      else
        network_response
      end
    end
    def self.network_response
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__ge=#{Time.zone.today.beginning_of_day.strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      JSON.parse resource.get
    end
    def self.mock_response
    end
    def self.orders
      if response["results"]
        results = response["results"]
        results = results.map do |json|
          tracking_number = json["tracking_number"]
          name = json["customer"]["name"]
          email = json["customer"]["email"]
          customer_id = json["customer_id"]
          cratejoy_id = json["id"]
          shipment_created_at = DateTime.parse(json["shipped_at"])
          customer = Customer.find_or_create_by(name: name,
                                                email: email,
                                               cratejoy_id: customer_id)
          Order.find_or_create_by(customer: customer,
                                  tracking_number: tracking_number,
                                  shipment_created_at: shipment_created_at,
                                  cratejoy_id: cratejoy_id)
        end
      else
        results = []
      end
      results
    end
  end
end
