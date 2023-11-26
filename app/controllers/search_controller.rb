
class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info[:officials].each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info[:offices].each do |office|
        if office[:official_indices].include?(index)
          title_temp = office[:name]
          ocdid_temp = office[:division_id]
        end
      end

      # lin1, city, state, zip
      addr_street = ''
      addr_city = ''
      addr_state = ''
      addr_zip = ''
      unless official.address.nil?
        addr_street = official.address.first.line1
        addr_city = official.address.first.city
        addr_state = official.address.first.state
        addr_zip = official.address.first.zip
      end
      
      already_exists = Representative.find_by(name: official[:name], title: title_temp)

      if already_exists.nil?
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp,
          address_street: addr_street, # official.address[0],
          address_city: addr_city, # official.address[1],
          address_state: addr_state, # official.address[2],
          address_zip: addr_zip, # official.address[3],
          party: official.party, photo_url: official.photo_url })
        reps.push(rep)
      else
        reps.push(already_exists)
      end
    end
    reps
  end
end# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)

    render 'representatives/search'
  end
end
