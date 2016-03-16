class CrateJoyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    ParamsForDaveMailer.test_email(params)
    render nothing: true
  end
end
