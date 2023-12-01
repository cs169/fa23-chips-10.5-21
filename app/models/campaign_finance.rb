require 'httparty'
require 'net/http'
require 'json'

class CampaignFinance < ApplicationRecord

  serialize :candidates_list, JSON

  def self.get_cycle_and_category(cycle, category)
    # if already stored, return values
    stored_vals = CampaignFinance.where(cycle: cycle, category: category)
    if stored_vals.count == 0
      api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
      propublica_service = PropublicaService.new(api_key)
      Rails.logger.info("API Key: #{api_key}")
      api_response = propublica_service.get_candidate_info(cycle, category)
      processed_candidates = CampaignFinance.add_candidates_to_db(api_response, cycle, category)
    end
    CampaignFinance.where(cycle: cycle, category: category)
  end

  def self.add_candidates_to_db(api_reponse, cycle, category)
    candidates_list = []
    Rails.logger.debug(api_reponse)
    json_info = JSON.parse(api_reponse)
    # Rails.logger.debug(api_reponse.methods)
    # Rails.logger.debug(json_info.to_s)
    # Rails.logger.debug(json_info.methods)
    json_info['results'].each do |candidate|
      candidates_list.push(candidate['name'])
    end
    finances = CampaignFinance.create!(candidates_list: candidates_list, cycle: cycle, category: category)
    finances
  end
end


class PropublicaService

  def initialize(api_key)
    @api_key = api_key
  end

  def get_candidate_info(cycle, category)
    url = URI.parse("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.path)
    request['X-API-Key'] = "#{@api_key}"
    response = http.request(request)
    Rails.logger.info("API Key: #{@api_key}")
    Rails.logger.info(url)
    #response = self.class.get("2015/candidates/leaders/pac-total.json", headers: {'X-API-Key' => "#{@api_key}"})
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.code.to_i == 200
      Rails.logger.debug("#{response.body}")
      response.body
    else
      raise "API request failed with status code #{response.code}: #{response.body}"
    end
  end
end