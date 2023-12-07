# frozen_string_literal: true

class CreateCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_finances do |t|
      t.json :candidates
      t.string :cycle
      t.string :category

      t.timestamps
    end
  end
end
