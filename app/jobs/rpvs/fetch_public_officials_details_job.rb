require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchPublicOfficialsDetailsJob < ApplicationJob
  
  queue_as :rpvs_public_officials_details

    def perform

    poArr = Array.new

    link = String.new

    open("https://rpvs.gov.sk/OpenData/VerejniFunkcionari?%24expand=Partner") do |url|

    if url.status[0] == "200"

     jsondata = JSON.parse url.base_uri.read

      link = jsondata["@odata.nextLink"]
    
      
      jsondata["value"].each do |data|

        poId = data["Id"]
        pofirstname = data["Meno"]
        polastname = data["Priezvisko"]
        pofronttitle = data["TitulPred"]
        pobacktitle = data["TitulZa"]
        povalidfrom = data["PlatnostOd"]
        povalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
        

      @po = Rpvs::Publicofficials.new(:partner_id => partnerID, :publicofficial_id => poId,:first_name=>pofirstname,:family_name=>polastname,:title_front=>pofronttitle,:title_back=>pobacktitle,:valid_from => povalidfrom,:valid_to => povalidto)

      poArr.push(@po)
    
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

        poId = data["Id"]
        pofirstname = data["Meno"]
        polastname = data["Priezvisko"]
        pofronttitle = data["TitulPred"]
        pobacktitle = data["TitulZa"]
        povalidfrom = data["PlatnostOd"]
        povalidto = data["PlatnostDo"]
        partnerID = data["Partner"]["Id"]
             
      
            @po = Rpvs::Publicofficials.new(:partner_id => partnerID, :publicofficial_id => poId,:first_name=>pofirstname,:family_name=>polastname,:title_front=>pofronttitle,:title_back=>pobacktitle,:valid_from => povalidfrom,:valid_to => povalidto )

      poArr.push(@po)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
    else
      puts "Error connecting to #{suburl.base_uri}"
    end

  
  end
  end

  Rpvs::Publicofficials.import poArr, on_duplicate_key_update: {conflict_target: [:publicofficial_id], columns: [:first_name,:family_name,:title_front,:title_back,:valid_from,:valid_to]}
  end


end
  