class CreateRpvsPartners < ActiveRecord::Migration[5.0]
   def up
    execute 'CREATE SCHEMA rpvs'

    create_table 'rpvs.publicsectorpartners' do |t|
      t.integer :partner_id, null: false
      t.integer :publicsectorpartner_id, null: false
      t.string :first_name
      t.string :family_name
      t.datetime :birth_date
      t.string :title_front
      t.string :title_back
      t.string :business_name
      t.string :cin
      t.string :business_form
      t.datetime :valid_from
      t.datetime :valid_to
      t.string :address_street_name
      t.string :address_street_number
      t.string :address_reg_number
      t.string :address_city
      t.string :address_code
      t.string :address_psc
      t.string :address_identifikator

      t.timestamps
    end

    add_index 'rpvs.publicsectorpartners', :publicsectorpartner_id, unique: true
    add_index 'rpvs.publicsectorpartners', :cin
    add_index 'rpvs.publicsectorpartners', :partner_id

     create_table 'rpvs.endusers' do |t|
      t.integer :partner_id, null: false
      t.integer :enduser_id, null: false
      t.string :first_name
      t.string :family_name
      t.datetime :birth_date
      t.string :title_front
      t.string :title_back
      t.boolean :is_public_figure
      t.string :business_name
      t.string :cin
      t.datetime :valid_from
      t.datetime :valid_to
      t.string :address_street_name
      t.string :address_street_number
      t.string :address_reg_number
      t.string :address_city
      t.string :address_code
      t.string :address_psc
      t.string :address_identifikator

      t.timestamps
    end

    add_index 'rpvs.endusers', :enduser_id, unique: true
    add_index 'rpvs.endusers', :cin
    add_index 'rpvs.endusers', :partner_id
    
create_table 'rpvs.authorizedpersons' do |t|
      t.integer :partner_id, null: false
      t.integer :authperson_id, null: false
      t.string :first_name
      t.string :family_name
      t.datetime :birth_date
      t.string :title_front
      t.string :title_back
      t.string :business_name
      t.string :cin
      t.string :business_form
      t.datetime :valid_from
      t.datetime :valid_to
      t.string :address_street_name
      t.string :address_street_number
      t.string :address_reg_number
      t.string :address_city
      t.string :address_code
      t.string :address_psc
      t.string :address_identifikator

      t.timestamps
    end

    add_index 'rpvs.authorizedpersons', :authperson_id, unique: true
    add_index 'rpvs.authorizedpersons', :cin
    add_index 'rpvs.authorizedpersons', :partner_id
    

create_table 'rpvs.publicofficials' do |t|
      t.integer :partner_id, null: false
      t.integer :publicofficial_id, null: false
      t.string :first_name
      t.string :family_name
      t.string :title_front
      t.string :title_back
      t.datetime :valid_from
      t.datetime :valid_to
      
      t.timestamps
    end

    add_index 'rpvs.publicofficials', :publicofficial_id, unique: true
    add_index 'rpvs.publicofficials', :partner_id


    create_table 'rpvs.partners' do |t|
      t.integer :partner_id, null: false
      t.integer :line, null: false
      t.integer :removal_id
      t.string :reason
      t.string :note
      t.datetime :removal_date
      
      t.timestamps
    end

    add_index 'rpvs.partners', :partner_id, unique: true
    add_index 'rpvs.partners', :line, unique: true

    

  end

  def down
    execute 'DROP SCHEMA rpvs CASCADE'
  end

  
end

