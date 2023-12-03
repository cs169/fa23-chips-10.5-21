require 'faraday'
require 'json'

class CampaignFinance < ApplicationRecord
  serialize :candidates_list, JSON

  def self.get_cycle_and_category(cycle, category)
    stored_vals = CampaignFinance.where(cycle: cycle, category: category)

    unless stored_vals.exists?
      api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
      propublica_service = PropublicaService.new(api_key)
      Rails.logger.info("API Key: #{api_key}")
      api_response = propublica_service.get_candidate_info(cycle, category)
      processed_candidates = CampaignFinance.add_candidates_to_db(api_response, cycle, category)
    end

    CampaignFinance.where(cycle: cycle, category: category)
  end

  def self.add_candidates_to_db(api_response, cycle, category)
    candidates_list = []
    json_info = JSON.parse(api_response)
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
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
    
    response = connection.get(url) do |req|
      req.headers['X-API-Key'] = @api_key
    end

    handle_response(response)
  end

  private

  def connection
    @connection ||= Faraday.new do |conn|
      conn.use Faraday::Request::UrlEncoded
      conn.use Faraday::Response::Logger if Rails.env.development?
      conn.adapter Faraday.default_adapter
    end
  end

  def handle_response(response)
    if response.status == 200
      Rails.logger.debug("#{response.body}")
      response.body
    else
      raise "API request failed with status code #{response.status}: #{response.body}"
    end
  end
end
