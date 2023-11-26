# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe Representative do
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
  end
end
