module CrateJoy

  def self.orders
    API.orders
  end

  class API
    def self.response
      if Rails.env.development?
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
          customer_id = json["customer_id"]
          #Order.new(name: name, customer_id: customer_id, tracking_number: tracking_number)
          Order.new(name, customer_id, tracking_number)
        end
      else
        results = []
      end
      results
    end
  end
end
