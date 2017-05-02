require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchPublicPartnersDetailsJob < ApplicationJob
  
  queue_as :rpvs_public_partners_details

  def perform

    norecord = Rpvs::Publicsectorpartners.pluck(:partner_id)
  
    partners = Rpvs::Partners.where.not(id: norecord)

    partners.each_slice(500) do |slice|

    

      psArr = Array.new

      slice.each do |partner|


     
        json = JSON.parse open("https://rpvs.gov.sk/OpenData/Partneri(#{partner.p_id.to_s})?%24expand=PartneriVerejnehoSektora").read
      
        json["PartneriVerejnehoSektora"].each do |jsondata|

        pspartnerId = jsondata["Id"]
        psfirstname = jsondata["Meno"]
        pslastname = jsondata["Priezvisko"]
        psbirthdate = jsondata["DatumNarodenia"]
        psfronttitle = jsondata["TitulPred"]
        psbacktitle = jsondata["TitulZa"]
        psbname = jsondata["ObchodneMeno"]
        psico = jsondata["Ico"]
        psbform = jsondata["FormaOsoby"]
        psvalidfrom = jsondata["PlatnostOd"]
        psvalidto = jsondata["PlatnostDo"]

        

       @ps = Rpvs::Publicsectorpartners.new(:partner_id => partner.id, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto)
      
        psArr.push(@ps)

      end
              
      end

      Rpvs::Publicsectorpartners.import psArr, on_duplicate_key_update: {conflict_target: [:publicsectorpartner_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:business_form,:valid_from,:valid_to]}

      
    end


  end


end
  