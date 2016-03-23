class CrateJoyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    hash = JSON.parse(params["_json"])
    CrateJoy::API.order_from_hash(hash)
    render nothing: true
  end
end
