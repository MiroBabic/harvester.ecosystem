require 'typhoeus'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchPublicPartnersDetailsHydraJob < ApplicationJob

  queue_as :rpvs_public_partners_details_hydra

  def perform

    norecord = Rpvs::Publicsectorpartners.pluck(:partner_id)
  
    partners = Rpvs::Partners.where.not(id: norecord)

    jsonarr = Array.new

   hydra = Typhoeus::Hydra.new(max_concurrency: 10)

   partners.each do |partner|

    request = Typhoeus::Request.new("https://rpvs.gov.sk/OpenData/Partneri(#{partner.partner_id.to_s})?%24expand=PartneriVerejnehoSektora",method: :get)
    request.on_complete do |response|

        if response.success?
          result = JSON.parse(response.body)

          jsonarr.push(result)
      
      elsif response.timed_out?
      
        puts "response timed out" + response.effective_url
      elsif response.code == 0
      
        puts response.return_message
      else
      
        puts "HTTP request failed: " + response.code.to_s
      end


    #puts response.body
    end
    hydra.queue(request)
    
    end

    hydra.run

    puts jsonarr.length

    
  importArr = Array.new

    jsonarr.each do |json|

      partner = json["Id"]

      json["PartneriVerejnehoSektora"].each do |partnervs|


       pspartnerId = partnervs["Id"]
        psfirstname = partnervs["Meno"]
        pslastname = partnervs["Priezvisko"]
        psbirthdate = partnervs["DatumNarodenia"]
        psfronttitle = partnervs["TitulPred"]
        psbacktitle = partnervs["TitulZa"]
        psbname = partnervs["ObchodneMeno"]
        psico = partnervs["Ico"]
        psbform = partnervs["FormaOsoby"]
        psvalidfrom = partnervs["PlatnostOd"]
        psvalidto = partnervs["PlatnostDo"]


        ps = Rpvs::Publicsectorpartners.new(:partner_id => partner, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto)

        importArr.push(ps)
    end
      
    end     

    Rpvs::Publicsectorpartners.import importArr, on_duplicate_key_update: {conflict_target: [:publicsectorpartner_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:business_form,:valid_from,:valid_to]}


  

   end
end
  