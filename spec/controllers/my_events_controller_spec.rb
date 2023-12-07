# require 'rails_helper'

# RSpec.describe MyEventsController, type: :controller do
#   describe 'GET #new' do
#     it 'assigns a new event to @event' do
#       get :new
#       expect(assigns(:event)).to be_a_new(Event)
#     end

#     it 'renders the new template' do
#       get :new
#       expect(response).to render_template(:new)
#     end
#   end

#   describe 'GET #edit' do
#     let(:event) { create(:event) }

#     it 'assigns the requested event to @event' do
#       get :edit, params: { id: event.id }
#       expect(assigns(:event)).to eq(event)
#     end

#     it 'renders the edit template' do
#       get :edit, params: { id: event.id }
#       expect(response).to render_template(:edit)
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid attributes' do
#       it 'creates a new event' do
#         expect {
#           post :create, params: { event: attributes_for(:event) }
#         }.to change(Event, :count).by(1)
#       end

#       it 'redirects to the events path' do
#         post :create, params: { event: attributes_for(:event) }
#         expect(response).to redirect_to(events_path)
#       end
#     end

#     context 'with invalid attributes' do
#       it 'does not create a new event' do
#         expect {
#           post :create, params: { event: attributes_for(:event, name: nil) }
#         }.not_to change(Event, :count)
#       end

#       it 'renders the new template' do
#         post :create, params: { event: attributes_for(:event, name: nil) }
#         expect(response).to render_template(:new)
#       end
#     end
#   end

#   describe 'PUT #update' do
#     let(:event) { create(:event) }

#     context 'with valid attributes' do
#       it 'updates the requested event' do
#         put :update, params: { id: event.id, event: { name: 'New Name' } }
#         event.reload
#         expect(event.name).to eq('New Name')
#       end

#       it 'redirects to the events path' do
#         put :update, params: { id: event.id, event: attributes_for(:event) }
#         expect(response).to redirect_to(events_path)
#       end
#     end

#     context 'with invalid attributes' do
#       it 'does not update the requested event' do
#         put :update, params: { id: event.id, event: { name: nil } }
#         event.reload
#         expect(event.name).not_to be_nil
#       end

#       it 'renders the edit template' do
#         put :update, params: { id: event.id, event: { name: nil } }
#         expect(response).to render_template(:edit)
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     let!(:event) { create(:event) }

#     it 'destroys the requested event' do
#       expect {
#         delete :destroy, params: { id: event.id }
#       }.to change(Event, :count).by(-1)
#     end

#     it 'redirects to the events path' do
#       delete :destroy, params: { id: event.id }
#       expect(response).to redirect_to(events_path)
#     end
#   end
# end