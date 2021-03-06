require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchPublicPartnersDetailsJob < ApplicationJob
  
  queue_as :rpvs_public_partners_details

  def perform

    psArr = Array.new

    link = String.new

    begin

    open("https://rpvs.gov.sk/OpenData/PartneriVerejnehoSektora?%24expand=Partner%2CAdresa") do |url|

    

     jsondata = JSON.parse url.base_uri.read

      link = jsondata["@odata.nextLink"]
    
      
      jsondata["value"].each do |data|

        pspartnerId = data["Id"]
        psfirstname = data["Meno"]
        pslastname = data["Priezvisko"]
        psbirthdate = data["DatumNarodenia"]
        psfronttitle = data["TitulPred"]
        psbacktitle = data["TitulZa"]
        psbname = data["ObchodneMeno"]
        psico = data["Ico"]
        psbform = data["FormaOsoby"]
        psvalidfrom = data["PlatnostOd"]
        psvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?


      @ps = Rpvs::Publicsectorpartners.new(:partner_id => partnerID, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      psArr.push(@ps)
    
     end

          
    end


    while link.present? do 

      begin

      open(link) do |suburl|

        

      jsondataloop = JSON.parse suburl.base_uri.read

      jsondataloop["value"].each do |data|

       pspartnerId = data["Id"]
        psfirstname = data["Meno"]
        pslastname = data["Priezvisko"]
        psbirthdate = data["DatumNarodenia"]
        psfronttitle = data["TitulPred"]
        psbacktitle = data["TitulZa"]
        psbname = data["ObchodneMeno"]
        psico = data["Ico"]
        psbform = data["FormaOsoby"]
        psvalidfrom = data["PlatnostOd"]
        psvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?

      
      
            @ps = Rpvs::Publicsectorpartners.new(:partner_id => partnerID, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      psArr.push(@ps)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
  end

  rescue OpenURI::HTTPError => error
      puts error.io.status
    end

  end

  Rpvs::Publicsectorpartners.import psArr, on_duplicate_key_update: {conflict_target: [:publicsectorpartner_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:business_form,:valid_from,:valid_to,:address_street_name, :address_street_number, :address_reg_number, :address_city,:address_code,:address_psc,:address_identifikator]}

 end

  rescue OpenURI::HTTPError => error
      puts error.io.status
  end


end
  