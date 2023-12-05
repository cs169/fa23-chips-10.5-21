# frozen_string_literal: true

class RemoveCandidatesFromCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    remove_column :campaign_finances, :candidates, :json
  end
end
