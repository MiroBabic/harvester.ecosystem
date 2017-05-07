namespace :rpvs do
  desc 'get all rpvs partners'
  task 'partners' => :environment do
    Rpvs::FetchAllPartnersJob.perform_now
  end
  
  desc 'get rpvs public partners details'
  task 'public_partners_details' => :environment do
    Rpvs::FetchPublicPartnersDetailsJob.perform_now
  end

  desc 'get rpvs end users details'
  task 'end_users_details' => :environment do
    Rpvs::FetchEndUsersDetailsJob.perform_now
  end

  desc 'get rpvs authorized persons details'
  task 'auth_persons_details' => :environment do
    Rpvs::FetchAuthorizedPersonsDetailsJob.perform_now
  end


  desc 'get rpvs public officials details'
  task 'public_officials_details' => :environment do
    Rpvs::FetchPublicOfficialsDetailsJob.perform_now
  end

  desc 'get rpvs public partners details with hydra (experimental)'
  task 'public_partners_details_hydra' => :environment do
    Rpvs::FetchPublicPartnersDetailsHydraJob.perform_now
  end

end
