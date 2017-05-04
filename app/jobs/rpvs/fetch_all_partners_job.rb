require 'open-uri'
require 'json'
require 'activerecord-import/base'


class Rpvs::FetchAllPartnersJob < ApplicationJob
  
  queue_as :rpvs_partners

  def perform

    jsondata = JSON.parse open("https://rpvs.gov.sk/OpenData/Partneri?%24expand=Vymaz").read
    
    partnersArr = Array.new
        
    jsondata["value"].each do |data|

      id = data["Id"]
      line = data["CisloVlozky"]
      removal = data["Vymaz"]

      
      
      unless removal.nil?
        removal_id = removal["Id"]
        reason = removal["Dovod"]
        note = removal["Poznamka"]
        removal_date = removal["Datum"]
      end

      p = Rpvs::Partners.new(:partner_id=>id, :line=>line, :removal_id => removal_id, :reason => reason, :note=> note, :removal_date => removal_date)

     

      partnersArr.push(p)
    
     end

    link = jsondata["@odata.nextLink"]

    while link.present? do 

      jsondataloop = JSON.parse open(link).read

      jsondataloop["value"].each do |data|

      id = data["Id"]
      line = data["CisloVlozky"]
      removal = data["Vymaz"]

      
      
      unless removal.nil?
        removal_id = removal["Id"]
        reason = removal["Dovod"]
        note = removal["Poznamka"]
        removal_date = removal["Datum"]
      end

      p = Rpvs::Partners.new(:partner_id=>id, :line=>line, :removal_id => removal_id, :reason => reason, :note=> note, :removal_date => removal_date)


     

      partnersArr.push(p)
    
     end
     
      link = jsondataloop["@odata.nextLink"]
      
    end

    Rpvs::Partners.import partnersArr, on_duplicate_key_update: {conflict_target: [:partner_id], columns: [:line, :removal_id,:reason, :note,:removal_date]}
    
  

  end


end
  