class CrateJoyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    hash = JSON.parse(params["_json"])
    shipment_id = hash["id"]
    CrateJoy::API.order_from_id(shipment_id)
    render nothing: true
  end
end
