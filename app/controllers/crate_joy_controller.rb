class CrateJoyController < ApplicationController
  def new
    ParamsForDaveMailer.test_email(params)
  end
end
