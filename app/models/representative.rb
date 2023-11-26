# frozen_string_literal: true

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

      already_exists = Representative.find_by(name: official[:name], title: title_temp)

      if already_exists.nil?
        rep = Representative.create!({ name: official[:name], ocdid: ocdid_temp, title: title_temp })
        reps.push(rep)
      else
        reps.push(already_exists)
      end
    end
    reps
  end
end
