namespace :orders do
  desc "Insert old stuff into the DB"
  task seed_old: :environment do
    CrateJoy::API.build_orders
  end

  task import_today: :environment do
    CrateJoy::API.build_today
  end

end
