# frozen_string_literal: true

# spec/controllers/news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  # Helper method to create a representative without FactoryBot
  def create_representative(attributes={})
    Representative.create!(
      name:           'John Doe',
      ocdid:          'some_ocdid',
      title:          'Representative',
      address_street: '123 Main St',
      address_city:   'Anytown',
      address_state:  'CA',
      address_zip:    '12345',
      party:          'Democrat',
      photo_url:      'https://example.com/john_doe.jpg',
      **attributes
    )
  end

  # Helper method to create a news_item without FactoryBot
  def create_news_item(representative, attributes={})
    NewsItem.create!(
      title:          'Sample News',
      link:           'https://example.com/sample_news',
      issue:          'Some Issue',
      description:    'Description of the news',
      representative: representative,
      **attributes
    )
  end

  describe 'GET #index' do
    it 'renders the index template' do
      representative = create_representative
      create_news_item(representative)

      get :index, params: { representative_id: representative.id }
      expect(response).to render_template(:index)
      expect(assigns(:news_items)).to eq(representative.news_items)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      representative = create_representative
      news_item = create_news_item(representative)

      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(response).to render_template(:show)
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  private

  def create_valid_news_item
    representative = create_representative
    post :create,
         params: { representative_id: representative.id,
                   news_item:         { title: 'Valid Title', link: 'https://example.com/valid_link' } }
  end

  def create_invalid_news_item
    representative = create_representative
    post :create,
         params: { representative_id: representative.id,
                   news_item:         { title: nil, link: 'https://example.com/invalid_link' } }
  end
end
