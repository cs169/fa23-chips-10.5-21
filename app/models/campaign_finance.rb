require 'faraday'
require 'json'

class CampaignFinance < ApplicationRecord
  serialize :candidates_list, JSON

  def self.get_cycle_and_category(cycle, category)
    stored_vals = CampaignFinance.where(cycle: cycle, category: category)

    unless stored_vals.exists?
      Rails.logger.info("cycle: #{cycle}, category: #{category}}")  

      api_response = CampaignFinance.get_candidate_info_from_api(cycle, category)
      if api_response.nil?
        return nil
      end
      Rails.logger.info("api_response: #{api_response}") 
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

  def self.get_candidate_info_from_api(cycle, category)
    Rails.logger.info("get_candidate_info method called") 
    puts "get_candidate_info method called"
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"
    
    Rails.logger.info("API Request URL: #{url}")
    puts "API Request URL: #{url}"
    api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
    headers = { 'X-API-Key' =>  api_key}
  
    response = CampaignFinance.faraday_connection.get(url, nil, headers)
    Rails.logger.info("API Request Headers: #{headers}")
    puts "API Request Headers: #{headers}"
    #response = FakeResponse.new(600, "nothing")

    CampaignFinance.handle_response(response)
  end
  
  def self.handle_response(response)
    Rails.logger.info("handle_response method called") 
    puts "handle_response method called"
    if response.status == 200
      Rails.logger.debug("#{response.body}")
      return response.body
    else
      #raise "API request failed with status code #{response.status}: #{response.body}"
      return nil
    end
  end

  def self.faraday_connection
    Rails.logger.info("connection method called")
    puts "connection method called"
    @connection ||= Faraday.new do |conn|
      conn.use Faraday::Request::UrlEncoded
      conn.use Faraday::Response::Logger 
      conn.adapter Faraday.default_adapter
    end
  end
  
end

class FakeResponse
  attr_accessor :status, :body

  def initialize(status, body)
    @status = status
    @body = body
  end
end

