class CrateJoyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    CrateJoy::API.order_from_hash(params["_json"])
    render nothing: true
  end
end
