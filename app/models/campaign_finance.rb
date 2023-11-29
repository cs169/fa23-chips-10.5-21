class CampaignFinance < ApplicationRecord
  def self.get_cycle_and_category(cycle, category)
    # if already stored, return values
    stored_vals = CampaignFinance.where(cycle: @cycle, category: @category)
    if stored_vals.count != 0
      return CampaignFinance.where(cycle: @cycle, category: @category)
    end
    # if not stored, retrieve from API
  end
end
