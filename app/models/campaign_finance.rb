# frozen_string_literal: true

require 'faraday'
require 'json'

class CampaignFinance < ApplicationRecord
  serialize :candidates_list, JSON

  def self.get_cycle_and_category(cycle, category)
    stored_vals = CampaignFinance.where(cycle: cycle, category: category)

    unless stored_vals.exists?
      Rails.logger.info("cycle: #{cycle}, category: #{category}}")

      api_response = CampaignFinance.get_candidate_info_from_api(cycle, category)
      return nil if api_response.nil?

      Rails.logger.info("api_response: #{api_response}")
      CampaignFinance.add_candidates_to_db(api_response, cycle, category)
    end

    CampaignFinance.where(cycle: cycle, category: category)
  end

  def self.add_candidates_to_db(api_response, cycle, category)
    candidates_list = []
    json_info = JSON.parse(api_response)
    json_info['results'].each do |candidate|
      candidates_list.push(candidate['name'])
    end

    CampaignFinance.create!(candidates_list: candidates_list, cycle: cycle, category: category)
  end

  def self.get_candidate_info_from_api(cycle, category)
    Rails.logger.info('get_candidate_info method called')
    Rails.logger.debug 'get_candidate_info method called'
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"

    Rails.logger.info("API Request URL: #{url}")
    Rails.logger.debug { "API Request URL: #{url}" }
    api_key = '9 l c j s l v w V j b q t X 0 K c Q Q 3 W 9 r F m 3 1 6 c a Q Q 2 T 8 9 n 4 x A '.gsub(/\s+/, '')
    headers = { 'X-API-Key' =>  api_key }

    response = CampaignFinance.faraday_connection.get(url, nil, headers)
    Rails.logger.info("API Request Headers: #{headers}")
    Rails.logger.debug { "API Request Headers: #{headers}" }
    # response = FakeResponse.new(600, "nothing")

    CampaignFinance.handle_response(response)
  end

  def self.handle_response(response)
    Rails.logger.info('handle_response method called')
    Rails.logger.debug 'handle_response method called'

    return unless response.status == 200

    Rails.logger.debug(response.body.to_s)
    response.body
  end

  def self.faraday_connection
    Rails.logger.info('connection method called')
    Rails.logger.debug 'connection method called'
    @faraday_connection ||= Faraday.new do |conn|
      conn.use Faraday::Request::UrlEncoded
      conn.use Faraday::Response::Logger
      conn.headers['X-API-Key'] = Rails.application.credentials[:PROPUBLICA_API_KEY]
      conn.adapter Faraday.default_adapter
    end
  end
end
