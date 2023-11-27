# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def get_address_from_official(official)
    addr = {}
    addr['street'] = ''
    addr['city'] = ''
    addr['state'] = ''
    addr['zip'] = ''
    unless official.address.nil?
      addr['street'] = official.address.first.line1
      addr['city'] = official.address.first.city
      addr['state'] = official.address.first.state
      addr['zip'] = official.address.first.zip
    end
    addr
  end

  def get_office_info(rep_info, index)
    info['ocdid'] = ''
    info['title'] = ''

    rep_info.offices.each do |office|
      if office.official_indices.include?(index)
        info['title'] = office.name
        info['ocdid'] = office.division_id
      end
    end
    info
  end

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      office_info = get_office_info(rep_info, index)
      already_exists = Representative.find_by(name: official.name, title: title_temp)
      if already_exists.nil?
        addr = get_address_from_official(official)
        rep = Representative.create!({ name: official.name, ocdid: office_info['ocdid'],
          title: office_info['title'], address_street: addr['street'], address_city: addr['city'],
          address_state: addr['state'], address_zip: addr['zip'],
          party: official.party, photo_url: official.photo_url })
        reps.push(rep)
      else
        reps.push(already_exists)
      end
    end
    reps
  end
end
