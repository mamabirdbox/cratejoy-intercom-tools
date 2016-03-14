module CrateJoy

  def self.orders
    API.orders
  end

  class API
    require 'net/http'
    base_url = "https://api.cratejoy.com/v1"
    auth_headers = {http_basic_authentication: ["mamabirdbox1", "YQP6xBs687QSUHX7"]}

    def self.orders
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/shipments/?shipped_at__ge=#{Time.zone.today.beginning_of_day.strftime("%FT%TZ")}", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      response = JSON.parse resource.get
      if response["results"]
        results = response["results"]
        results = results.map do |result|
          Order.new(result)
        end
      else
        results = []
      end
      results
    end
  end
end
