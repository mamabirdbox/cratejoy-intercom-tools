module CrateJoy

  def self.orders
    API.orders
  end

  class API
    require 'net/http'
    base_url = "https://api.cratejoy.com/v1"
    auth_headers = {http_basic_authentication: ["mamabirdbox1", "YQP6xBs687QSUHX7"]}

    def self.orders
      resource = ::RestClient::Resource.new "https://api.cratejoy.com/v1/orders", 'mamabirdbox1', 'YQP6xBs687QSUHX7'
      response = JSON.parse resource.get
      if response["results"]
        results = response["results"]
      else
        results = []
      end
      results
    end
  end
end
