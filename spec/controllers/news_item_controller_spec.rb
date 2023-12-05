# spec/controllers/news_items_controller_spec.rb

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { representative_id: representative.id }
      expect(response).to render_template(:index)
      expect(assigns(:news_items)).to eq(representative.news_items)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(response).to render_template(:show)
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  private

  def create_valid_news_item
    post :create, params: { representative_id: representative.id, news_item: attributes_for(:news_item) }
  end

  def create_invalid_news_item
    post :create, params: { representative_id: representative.id, news_item: attributes_for(:news_item, title: nil) }
  end
end