# frozen_string_literal: true

# app/controllers/search_controller.rb

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]

    begin
      service = Google::Apis::CivicinfoV2::CivicInfoService.new
      service.key = Rails.application.credentials[:GOOGLE_API_KEY]
      result = service.representative_info_by_address(address: address)
      @representatives = Representative.civic_api_to_representative_params(result)
    rescue Google::Apis::ClientError => e
      flash[:error] = "Failed to parse address: #{e.message}"
      redirect_to representatives_path
      return
    end

    render 'representatives/search'
  end
end
