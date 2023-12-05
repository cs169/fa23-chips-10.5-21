# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'
# require 'spec_helper'

# class MockedAPIResponse
#   attr_accessor :officials, :offices

#   def initialize(officials, offices)
#     @officials = officials
#     @offices = offices
#   end
# end

# class MockedOfficial
#   attr_accessor :name, :party, :address, :photo_url

#   def initialize(name, party, address, photo_url)
#     @name = name
#     @party = party
#     @address = address
#   end
# end

# class MockedAddress
#   attr_accessor :line1, :city, :state, :zip

#   def initialize(line1, city, state, zip)
#     @line1 = line1
#     @city = city
#     @state = state
#     @zip = zip
#   end
# end

# class MockedOffice
#   attr_accessor :title, :ocdid

#   def initialize(title, ocdid)
#     @title = title
#     @ocdid = ocdid
#   end
# end

# describe Representative do
#   let(:john_doe_rep_info) do
#     {
#       officials: [{ name: 'John Doe' }],
#       offices:   [{ name: 'Representative', division_id: 'ocd-division/country:us/state:ca/district:33',
#                      official_indices: [0] }]
#     }
#   end

#   let(:existing_representative) do
#     described_class.new(
#       name:  'John Doe',
#       ocdid: 'ocd-division/country:us/state:ca/district:33',
#       title: 'Representative'
#     )
#   end

#   it 'adds a representative to the database if not yet in the database' do
#     allow(described_class).to receive(:find_by).and_return(nil)
#     allow(described_class).to receive(:create!).and_return(existing_representative)

#     representatives = described_class.civic_api_to_representative_params(john_doe_rep_info)

#     expect(representatives).to contain_exactly(existing_representative)
#   end

#   it 'returns an existing representative if already in the database' do
#     allow(described_class).to receive(:find_by).and_return(existing_representative)
#     allow(described_class).to receive(:create!)

#     representatives = described_class.civic_api_to_representative_params(john_doe_rep_info)

#     expect(representatives).to contain_exactly(existing_representative)
#   end

#   describe '.get_address_from_official' do
#     it 'returns a hash with address information' do
#       official = double('official',
#                         address: [double('address', line1: '123 Main St', city: 'City', state: 'CA', zip: '12345')])
#       address = Representative.get_address_from_official(official)
#       expect(address).to eq({
#                               'street' => '123 Main St',
#                               'city'   => 'City',
#                               'state'  => 'CA',
#                               'zip'    => '12345'
#                             })
#     end
#   end

#   describe '.get_office_info' do
#     it 'returns a hash with office information' do
#       rep_info = double('rep_info', offices: [
#                           double('office', name: 'Office 1', official_indices: [0]),
#                           double('office', name: 'Office 2', official_indices: [1])
#                         ])
#       index = 0
#       office_info = Representative.get_office_info(rep_info, index)
#       expect(office_info).to eq({
#                                   'ocdid' => 'DivisionID1',
#                                   'title' => 'Office 1'
#                                 })
#     end
#   end

#   describe '.civic_api_to_representative_params' do
#     it 'creates representative records from Civic API data' do
#       mock_address =
#       rep_info = MockedAPIResponse()
#       #rep_info = double('rep_info', officials: [
#       #                    double('official', name: 'John Doe', party: 'Independent', photo_url: 'http://example.com/photo1'),
#       #                    double('official', name: 'Jane Doe', party: 'Republican', photo_url: 'http://example.com/photo2')
#       #                  ])

#       expect(representatives.count).to eq(2)
#       expect(representatives[0]).to have_attributes(
#         name:           'John Doe',
#         ocdid:          'DivisionID1',
#         title:          'Office 1',
#         address_street: '',
#         address_city:   '',
#         address_state:  '',
#         address_zip:    '',
#         party:          'Independent',
#         photo_url:      'http://example.com/photo1'
#       )
#     end
#   end
# end
