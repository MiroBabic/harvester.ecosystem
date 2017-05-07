require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchEndUsersDetailsJob < ApplicationJob
  
  queue_as :rpvs_end_users_details

   def perform

    euArr = Array.new

    link = String.new

    begin

    open("https://rpvs.gov.sk/OpenData/KonecniUzivateliaVyhod?%24expand=Partner%2CAdresa") do |url|

    

     jsondata = JSON.parse url.base_uri.read

      link = jsondata["@odata.nextLink"]
          
      
      jsondata["value"].each do |data|

        euId = data["Id"]
        eufirstname = data["Meno"]
        eulastname = data["Priezvisko"]
        eubirthdate = data["DatumNarodenia"]
        eufronttitle = data["TitulPred"]
        eubacktitle = data["TitulZa"]
        eubname = data["ObchodneMeno"]
        euico = data["Ico"]
        euispublic = data["JeVerejnyCinitel"]
        euvalidfrom = data["PlatnostOd"]
        euvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?


      @eu = Rpvs::Endusers.new(:partner_id => partnerID, :enduser_id => euId,:first_name=>eufirstname,:family_name=>eulastname,:birth_date=>eubirthdate,:title_front=>eufronttitle,:title_back=>eubacktitle,:business_name =>eubname,:is_public_figure=>euispublic,:cin=>euico,:valid_from => euvalidfrom,:valid_to => euvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      euArr.push(@eu)
    
     end

     
  end


    while link.present? do 
     
      begin

      open(link) do |suburl|

     jsondataloop = JSON.parse suburl.base_uri.read

      jsondataloop["value"].each do |data|

        euId = data["Id"]
        eufirstname = data["Meno"]
        eulastname = data["Priezvisko"]
        eubirthdate = data["DatumNarodenia"]
        eufronttitle = data["TitulPred"]
        eubacktitle = data["TitulZa"]
        eubname = data["ObchodneMeno"]
        euico = data["Ico"]
        euispublic = data["JeVerejnyCinitel"]
        euvalidfrom = data["PlatnostOd"]
        euvalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        addressStreetName = data["Adresa"]["MenoUlice"] unless data["Adresa"].nil?
        addressStreetNumber = data["Adresa"]["OrientacneCislo"] unless data["Adresa"].nil?
        addressRegNumber = data["Adresa"]["SupisneCislo"] unless data["Adresa"].nil?
        addressCity = data["Adresa"]["Mesto"] unless data["Adresa"].nil?
        addressCode = data["Adresa"]["MestoKod"] unless data["Adresa"].nil?
        addressPsc = data["Adresa"]["Psc"] unless data["Adresa"].nil?
        addressIdent = data["Adresa"]["Identifikator"] unless data["Adresa"].nil?

      
      
            @eu = Rpvs::Endusers.new(:partner_id => partnerID, :enduser_id => euId,:first_name=>eufirstname,:family_name=>eulastname,:birth_date=>eubirthdate,:title_front=>eufronttitle,:title_back=>eubacktitle,:business_name =>eubname,:cin=>euico,:is_public_figure=>euispublic,:valid_from => euvalidfrom,:valid_to => euvalidto, :address_street_name => addressStreetName, :address_street_number => addressStreetNumber, :address_reg_number => addressRegNumber,:address_city => addressCity, :address_code => addressCode, :address_psc => addressPsc, :address_identifikator => addressIdent)

      euArr.push(@eu)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
   
    end

    rescue OpenURI::HTTPError => error
      puts error.io.status
    end


  end

  
  Rpvs::Endusers.import euArr, on_duplicate_key_update: {conflict_target: [:enduser_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:cin,:is_public_figure,:valid_from,:valid_to,:address_street_name, :address_street_number, :address_reg_number, :address_city,:address_code,:address_psc,:address_identifikator]}
  end

  rescue OpenURI::HTTPError => error
      puts error.io.status
    end


end
  
  