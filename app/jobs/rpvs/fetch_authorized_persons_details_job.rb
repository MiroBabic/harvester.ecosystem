require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchAuthorizedPersonsDetailsJob < ApplicationJob
  
  queue_as :rpvs_authorized_persons_details

    def perform

    auArr = Array.new

    link = String.new

    open("https://rpvs.gov.sk/OpenData/OpravneneOsoby?%24expand=Partner%2CAdresa") do |url|

    if url.status[0] == "200"

     jsondata = JSON.parse url.base_uri.read

      link = jsondata["@odata.nextLink"]
    
      
      jsondata["value"].each do |data|

        auId = data["Id"]
        aufirstname = data["Meno"]
        aulastname = data["Priezvisko"]
        aubirthdate = data["DatumNarodenia"]
        aufronttitle = data["TitulPred"]
        aubacktitle = data["TitulZa"]
        aubname = data["ObchodneMeno"]
        auico = data["Ico"]
        aubform = data["FormaOsoby"]
        auvalidfrom = data["PlatnostOd"]
        auvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?


      @au = Rpvs::Authorizedpersons.new(:partner_id => partnerID, :authperson_id => auId,:first_name=>aufirstname,:family_name=>aulastname,:birth_date=>aubirthdate,:title_front=>aufronttitle,:title_back=>aubacktitle,:business_name =>aubname,:cin=>auico,:business_form =>aubform,:valid_from => auvalidfrom,:valid_to => auvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      auArr.push(@au)
    
     end

     
     else

      puts "Error connecting to #{url.base_uri}"

      end
    end


    while link.present? do 


      open(link) do |suburl|

        if suburl.status[0]== "200"

      jsondataloop = JSON.parse suburl.base_uri.read

      jsondataloop["value"].each do |data|

        auId = data["Id"]
        aufirstname = data["Meno"]
        aulastname = data["Priezvisko"]
        aubirthdate = data["DatumNarodenia"]
        aufronttitle = data["TitulPred"]
        aubacktitle = data["TitulZa"]
        aubname = data["ObchodneMeno"]
        auico = data["Ico"]
        aubform = data["FormaOsoby"]
        auvalidfrom = data["PlatnostOd"]
        auvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?

      
      
            @au = Rpvs::Authorizedpersons.new(:partner_id => partnerID, :authperson_id => auId,:first_name=>aufirstname,:family_name=>aulastname,:birth_date=>aubirthdate,:title_front=>aufronttitle,:title_back=>aubacktitle,:business_name =>aubname,:cin=>auico,:business_form =>aubform,:valid_from => auvalidfrom,:valid_to => auvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      auArr.push(@au)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
    else
      puts "Error connecting to #{suburl.base_uri}"
    end

  
  end
  end

  Rpvs::Authorizedpersons.import auArr, on_duplicate_key_update: {conflict_target: [:authperson_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:business_form,:valid_from,:valid_to,:address_street_name, :address_street_number, :address_reg_number, :address_city,:address_code,:address_psc,:address_identifikator]}
  end


end
  