require 'csv'
require 'harvester_utils/downloader'
require 'json'

class Rpvs::FetchPartnersJob < ApplicationJob
  # TODO timeouts
  queue_as :rpvs

  def perform(downloader: HarvesterUtils::Downloader)
    jsondata = JSON.parse open("https://rpvs.gov.sk/OpenData/Partneri?%24skip=0&%24expand=PartneriVerejnehoSektora").read
    
  end
end
