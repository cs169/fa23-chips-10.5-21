

class PropublicaService
  include HTTParty
  base_uri 'https://api.propublica.org/campaign-finance/v1'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_candidate_info(cycle, category)
    headers = {
      'Content-Type' => 'application/json',
      'X-API-Key' => @api_key
    }

    response = self.class.get("/#{cycle}/candidates/leaders/#{category}", headers: headers)
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      response.parsed_response
    else
      raise "API request failed with status code #{response.code}: #{response.body}"
    end
  end
end
