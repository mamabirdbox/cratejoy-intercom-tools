class ParamsForDaveMailer < ApplicationMailer

  default from: 'kormie@gmail.com'

  def test_email(params)
    @params = params
    mail(to: 'david@ambushconsulting.com', subject: 'CrateJoy Params')
  end
end
