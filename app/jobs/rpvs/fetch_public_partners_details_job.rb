require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchPublicPartnersDetailsJob < ApplicationJob
  
  queue_as :rpvs_public_partners_details

  def perform

    psArr = Array.new

    link = String.new

    open("https://rpvs.gov.sk/OpenData/PartneriVerejnehoSektora?%24expand=Partner%2CAdresa") do |url|

    if url.status[0] == "200"

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
        addressStreetName = data["Adresa"]["MenoUlice"]
        addressStreetNumber = data["Adresa"]["OrientacneCislo"]
        addressRegNumber = data["Adresa"]["SupisneCislo"]
        addressCity = data["Adresa"]["Mesto"]
        addressCode = data["Adresa"]["MestoKod"]
        addressPsc = data["Adresa"]["Psc"]
        addressIdent = data["Adresa"]["Identifikator"]


      @ps = Rpvs::Publicsectorpartners.new(:partner_id => partnerID, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      psArr.push(@ps)
    
     end

     
     else

      puts "Error connecting to #{url.base_uri}"

      end
    end


    puts "hello"


    while link.present? do 


      open(link) do |suburl|

        if suburl.status[0]== "200"

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
        addressStreetName = data["Adresa"]["MenoUlice"]
        addressStreetNumber = data["Adresa"]["OrientacneCislo"]
        addressRegNumber = data["Adresa"]["SupisneCislo"]
        addressCity = data["Adresa"]["Mesto"]
        addressCode = data["Adresa"]["MestoKod"]
        addressPsc = data["Adresa"]["Psc"]
        addressIdent = data["Adresa"]["Identifikator"]

      
      
            @ps = Rpvs::Publicsectorpartners.new(:partner_id => partnerID, :publicsectorpartner_id => pspartnerId,:first_name=>psfirstname,:family_name=>pslastname,:birth_date=>psbirthdate,:title_front=>psfronttitle,:title_back=>psbacktitle,:business_name =>psbname,:cin=>psico,:business_form =>psbform,:valid_from => psvalidfrom,:valid_to => psvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      psArr.push(@ps)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
    else
      puts "Error connecting to #{suburl.base_uri}"
    end

  
  end
  end

  Rpvs::Publicsectorpartners.import psArr, on_duplicate_key_update: {conflict_target: [:publicsectorpartner_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:business_form,:valid_from,:valid_to,:address_street_name, :address_street_number, :address_reg_number, :address_city,:address_code,:address_psc,:address_identifikator]}
  end


end
  