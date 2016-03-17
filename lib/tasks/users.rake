namespace :users do
  desc "TODO"
  task seed_admins: :environment do
    User.destroy_all
    admin_data = [{:email=>"steven@mamabirdbox.com", :intercom_id=>189871, :password=>"mamabirdbox12"}, {:email=>"kyle@mamabirdbox.com", :intercom_id=>197001, :password=>"mamabirdbox12"}, {:email=>"beth@mamabirdbox.com", :intercom_id=>198218, :password=>"mamabirdbox12"}, {:email=>"becca@mamabirdbox.com", :intercom_id=>204996, :password=>"mamabirdbox12"}, {:email=>"julie@mamabirdbox.com", :intercom_id=>325089, :password=>"mamabirdbox12"}]
    admin_data.each do |admin|
      puts "Creating #{admin[:email]}"
      User.new(admin).save!
    end
  end

end
