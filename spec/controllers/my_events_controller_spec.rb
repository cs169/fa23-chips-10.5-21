# spec/controllers/my_events_controller_spec.rb

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }

    it 'renders the edit template' do
      get :edit, params: { id: event.id }
      expect(response).to render_template(:edit)
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new event' do
        expect {
          post :create, params: { event: attributes_for(:event) }
        }.to change(Event, :count).by(1)

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new event' do
        expect {
          post :create, params: { event: attributes_for(:event, name: nil) }
        }.not_to change(Event, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let(:event) { create(:event) }

    context 'with valid parameters' do
      it 'updates the event' do
        patch :update, params: { id: event.id, event: { name: 'Updated Name' } }

        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully updated.')
        expect(event.reload.name).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the event' do
        patch :update, params: { id: event.id, event: { name: nil } }

        expect(response).to render_template(:edit)
        expect(event.reload.name).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create(:event) }

    it 'destroys the event' do
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)

      expect(response).to redirect_to(events_url)
      expect(flash[:notice]).to eq('Event was successfully destroyed.')
    end
  end
end