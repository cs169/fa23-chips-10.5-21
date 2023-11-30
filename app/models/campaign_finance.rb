require 'httparty'
require 'net/http'

class CampaignFinance < ApplicationRecord

  serialize :candidates_list, JSON

  def self.get_cycle_and_category(cycle, category)
    # if already stored, return values
    stored_vals = CampaignFinance.where(cycle: cycle, category: category)
    if stored_vals.count != 0
      return CampaignFinance.where(cycle: cycle, category: category)
    else
      api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
      propublica_service = PropublicaService.new(api_key)
      Rails.logger.info("API Key: #{api_key}")
      api_candidates = propublica_service.get_candidate_info(cycle, category)
      processed_candidates = CampaignFinance.add_candidates_to_db(api_candidates, cycle, category)
    end
    # if not stored, retrieve from API
  end

  def self.add_candidates_to_db(api_candidate_info, cycle, category)
    candidate_list = []
    api_candidate_info.results.each do |candidate|
      candidate_list.push(candidate.name)
    end
    save_value = {candidates: candidate_list}
    CampaignFinance.new(candidate_list: candidate_list, cycle: cycle, category: category)
  end
end


class PropublicaService
  include HTTParty
  
  base_uri "https://api.propublica.org/campaign-finance/v1/"

  def initialize(api_key)
    @api_key = api_key
  end

  def get_candidate_info(cycle, category)
    url = URI.parse("https://api.propublica.org/campaign-finance/v1/2016/candidates/leaders/pac-total.json")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.path)
    request['X-API-Key'] = "#{@api_key}"
    response = http.request(request)
    #Rails.logger.info("API Key: #{@api_key}")
    #response = self.class.get("2015/candidates/leaders/pac-total.json", headers: {'X-API-Key' => "#{@api_key}"})
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.code.to_i == 200
      response.body
      Rails.logger.debug("#{response.body}")
    else
      raise "API request failed with status code #{response.code}: #{response.body}"
    end
  end
end