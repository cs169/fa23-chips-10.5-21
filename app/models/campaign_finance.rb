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


  def get_candidate_info(cycle, category)
    url = URI.parse("https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.path)
    request['X-API-Key'] = "#{@api_key}"
    response = http.request(request)
    Rails.logger.info("API Key: #{@api_key}")
    Rails.logger.info("#{url}")
    #response = self.class.get("2015/candidates/leaders/pac-total.json", headers: {'X-API-Key' => "#{@api_key}"})
    handle_response(response)
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

