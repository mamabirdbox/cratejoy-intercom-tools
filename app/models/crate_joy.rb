module CrateJoy
  class API
    def self.response
      if !Rails.env.development?
        MockResponseData.response
      else
        network_response
      end
    end
    def self.inner_get(url)
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/#{url}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      inner_response = JSON.parse resource.get
      build_from_response(inner_response)
      if inner_response["next"]
        inner_get(inner_response["next"])
      end
    end
    def self.network_response
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__le=#{(Time.zone.today.beginning_of_day - 5.days).strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      inner_response = JSON.parse resource.get
      build_from_response(inner_response)
      if inner_response["next"]
        inner_get(inner_response["next"])
      end
    end
    def self.build_from_response(json)
      byebug
      if json["results"]
        results = json["results"]
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
          puts "Order Saved: #{shipment_created_at}"
        end
      end
    end
    def self.build_orders
      build_from_response(response)
    end
  end
end
