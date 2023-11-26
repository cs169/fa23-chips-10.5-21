# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp, address_street: official.address.first.line1, 
          address_city: official.address.first.city, 
          address_state: official.address.first.state, 
          address_zip: official.address.first.zip, 
          party: offical.party, photo_url: offical.photo_url
        })
      reps.push(rep)
    end

    reps
  end
end
