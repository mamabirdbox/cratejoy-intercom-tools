# Preview all emails at http://localhost:3000/rails/mailers/params_for_dave_mailer
class ParamsForDaveMailerPreview < ActionMailer::Preview
  def test_email
    params = {"utf8"=>"✓", "_method"=>"patch", "authenticity_token"=>"LiIcq1GfVsebir5eTdrh5G6N/u1K3LdXKeX4IkWjlivpmHtAB0xTQsQE05CNXSfnB6HfWonUpilMTrlV7D5p2A==", "id"=>"81", "order"=>{"box_id"=>"1"}, "commit"=>"Update", "controller"=>"order", "action"=>"update", "format"=>"81"}
    ParamsForDaveMailer.test_email(params)
  end
end
