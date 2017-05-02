require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchEndUsersDetailsJob < ApplicationJob
  
  queue_as :rpvs_end_users_details

  def perform

    norecord = Rpvs::Endusers.pluck(:partner_id)
  
    partners = Rpvs::Partners.where.not(id: norecord)

    partners.each_slice(500) do |slice|

    

      euArr = Array.new

      slice.each do |partner|

     
        json = JSON.parse open("https://rpvs.gov.sk/OpenData/Partneri(#{partner.p_id.to_s})?%24expand=KonecniUzivateliaVyhod").read
      
        json["KonecniUzivateliaVyhod"].each do |jsondata|

        eupartnerId = jsondata["Id"]
        eufirstname = jsondata["Meno"]
        eulastname = jsondata["Priezvisko"]
        eubirthdate = jsondata["DatumNarodenia"]
        eufronttitle = jsondata["TitulPred"]
        eubacktitle = jsondata["TitulZa"]
        eubname = jsondata["ObchodneMeno"]
        euispublic = jsondata["JeVerejnyCinitel"]
        euico = jsondata["Ico"]
        euvalidfrom = jsondata["PlatnostOd"]
        euvalidto = jsondata["PlatnostDo"]


       @eu = Rpvs::Endusers.new(:partner_id => partner.id, :enduser_id => eupartnerId,:first_name=>eufirstname,:family_name=>eulastname,:birth_date=>eubirthdate,:title_front=>eufronttitle,:title_back=>eubacktitle,:business_name =>eubname, :is_public_figure=>euispublic,:cin=>euico,:valid_from => euvalidfrom,:valid_to => euvalidto)
      
        euArr.push(@eu)

      end
              
      end

     Rpvs::Endusers.import euArr, on_duplicate_key_update: {conflict_target: [:enduser_id], columns: [:first_name,:family_name,:birth_date,:title_front,:title_back,:business_name,:is_public_figure,:cin,:valid_from,:valid_to]}

      
    end


  end


end
  