require 'rails_helper'
require 'spec_helper'

describe Representative do
  it 'adds representative to db if not yet in db' do
    rep_info = {
      officials: [{ name: 'John Doe' }],
      offices:   [{ name: 'Representative', division_id: 'ocd-division/country:us/state:ca/district:33',
      official_indices: [0] }]
    }

    # Mock the Representative.find_by call to return nil
    allow(Representative).to receive(:find_by).and_return(nil)

    # Mock the Representative.create call
    allow(Representative).to receive(:create!).and_return(Representative.new(name: 'John Doe',
                                                                             ocdid: 'ocd-division/country:us/state:ca/district:33', title: 'Representative'))

    representatives = Representative.civic_api_to_representative_params(rep_info)

    expect(representatives.count).to eq(1)
    expect(representatives.first.name).to eq('John Doe')
    expect(representatives.first.ocdid).to eq('ocd-division/country:us/state:ca/district:33')
    expect(representatives.first.title).to eq('Representative')
  end

  it 'returns existing representative if already in db' do
    rep_info = {
      officials: [{ name: 'John Doe' }],
      offices:   [{ name: 'Representative', division_id: 'ocd-division/country:us/state:ca/district:33',
      official_indices: [0] }]
    }

    # Mock the Representative.find_by call to return an existing representative
    existing_representative = Representative.new(name: 'John Doe',
                                                  ocdid: 'ocd-division/country:us/state:ca/district:33', title: 'Representative')
    allow(Representative).to receive(:find_by).and_return(existing_representative)

    # Mock the Representative.create call
    allow(Representative).to receive(:create!)

    representatives = Representative.civic_api_to_representative_params(rep_info)

    expect(representatives.count).to eq(1)
    expect(representatives.first).to eq(existing_representative)
  end
end
