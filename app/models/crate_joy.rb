module CrateJoy
  class API
    def self.response
      if Rails.env.development?
        MockResponseData.response
      else
        network_response
      end
    end
    def self.order_from_id(id)
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/#{id}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      response = JSON.parse resource.get
      order_from_hash(response)
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
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__le=#{(Time.zone.today.beginning_of_day).strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      inner_response = JSON.parse resource.get
      build_from_response(inner_response)
      if inner_response["next"]
        inner_get(inner_response["next"])
      end
    end
    def self.build_from_date(date)
      date_array = date.split('-')
      current_year = Date.today.year
      ordered_date_string = [current_year, date_array[0], date_array[1]]
      date_object = DateTime.parse ordered_date_string.join('-')
      if date_object.future?
        date_object = date_object - 1.year
      end
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__ge=#{date_object.strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      inner_response = JSON.parse resource.get
      build_from_response(inner_response)
      if inner_response["next"]
        inner_get(inner_response["next"])
      end
    end

    def self.build_today
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__ge=#{(Time.zone.today.beginning_of_day - 1.day).strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      response = JSON.parse resource.get
      build_from_response(response)
    end
    def self.build_from_response(json)
      if json["results"]
        results = json["results"]
        results = results.map do |json|
          order_from_hash(json)
        end
      end
    end
    def self.build_orders
      build_from_response(response)
    end
    def self.order_from_hash(hash)
      tracking_number = hash["tracking_number"]
      name = hash["customer"]["name"]
      email = hash["customer"]["email"]
      customer_id = hash["customer_id"] || hash["customer"]["id"]
      cratejoy_id = hash["id"]
      shipped_at = hash["shipped_at"]
      if hash["fulfillments"].first["order"] && hash["fulfillments"].first["order"]["subscriptions"] && hash["fulfillments"].first["order"]["subscriptions"].first
        note = hash["fulfillments"].first["order"]["subscriptions"].first["note"]
      else
        note = nil
      end
      if shipped_at.is_a?(Integer)
        shipment_created_at = shipped_at.to_s.first(10).to_i
        shipment_created_at = Time.at(shipment_created_at)
        shipment_created_at = DateTime.parse(shipment_created_at.to_s)
      else
        shipment_created_at = DateTime.parse(shipped_at)
      end
      customer = Customer.find_or_create_by(name: name,
                                            email: email,
                                           cratejoy_id: customer_id)
      Order.find_or_create_by(customer: customer,
                              tracking_number: tracking_number,
                              shipment_created_at: shipment_created_at,
                              note: note,
                              cratejoy_id: cratejoy_id)
    end
  end
end
