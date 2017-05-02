namespace :rpvs do
  desc 'get all rpvs partners'
  task 'partners' => :environment do
    Rpvs::FetchAllPartnersJob.perform_now
  end
  
  desc 'get rpvs public partners details with open uri (slow)'
  task 'public_partners_details' => :environment do
    Rpvs::FetchPublicPartnersDetailsJob.perform_now
  end

  desc 'get rpvs end users details with open uri (slow)'
  task 'end_users_details' => :environment do
    Rpvs::FetchEndUsersDetailsJob.perform_now
  end

  desc 'get rpvs public partners details with hydra (experimental)'
  task 'public_partners_details_hydra' => :environment do
    Rpvs::FetchPublicPartnersDetailsHydraJob.perform_now
  end

end
