class CampaignFinancesController < ApplicationController
  def search_form
    # Action for the page to specify the cycle and category
  end

  def search_results
    # Action for displaying the search results
    @cycle = params[:cycle]
    @category = params[:category]
    
    # Perform a search query based on the cycle and category
    @finances = CampaignFinance.get_cycle_and_category(@cycle, @category)
    #@finances = CampaignFinance.where(cycle: @cycle, category: @category)
  end
end
