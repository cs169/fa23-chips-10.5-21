# frozen_string_literal: true

class AddCandidatesListToCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    add_column :campaign_finances, :candidates_list, :text
  end
end
