<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> Modified code passes first test
require 'rails_helper'
require 'spec_helper'

describe Representative do
<<<<<<< HEAD
  let(:john_doe_rep_info) do
    {
      officials: [{ name: 'John Doe' }],
      offices:   [{ name: 'Representative', division_id: 'ocd-division/country:us/state:ca/district:33',
                     official_indices: [0] }]
    }
  end

  let(:existing_representative) do
    described_class.new(
      name:  'John Doe',
      ocdid: 'ocd-division/country:us/state:ca/district:33',
      title: 'Representative'
    )
  end

  it 'adds a representative to the database if not yet in the database' do
    allow(described_class).to receive(:find_by).and_return(nil)
    allow(described_class).to receive(:create!).and_return(existing_representative)

    representatives = described_class.civic_api_to_representative_params(john_doe_rep_info)

    expect(representatives).to contain_exactly(existing_representative)
  end

  it 'returns an existing representative if already in the database' do
    allow(described_class).to receive(:find_by).and_return(existing_representative)
    allow(described_class).to receive(:create!)

    representatives = described_class.civic_api_to_representative_params(john_doe_rep_info)

    expect(representatives).to contain_exactly(existing_representative)
=======
  it 'adds representative to db if not yet in db' do
    rep_info = {
      officials: [{ name: 'John Doe' }],
      offices: [{ name: 'Representative', division_id: 'ocd-division/country:us/state:ca/district:33',
      official_indices: [0] }]
    }

    # Mock the Representative.find_by call to return nil
    allow(Representative).to receive(:find_by).and_return(nil)

    # Mock the Representative.create call
    allow(Representative).to receive(:create!).and_return(Representative.new(name: 'John Doe', ocdid: 'ocd-division/country:us/state:ca/district:33', title: 'Representative'))

    representatives = Representative.civic_api_to_representative_params(rep_info)

    expect(representatives.count).to eq(1)
    expect(representatives.first.name).to eq('John Doe')
    expect(representatives.first.ocdid).to eq('ocd-division/country:us/state:ca/district:33')
    expect(representatives.first.title).to eq('Representative')
>>>>>>> Modified code passes first test
  end
end
