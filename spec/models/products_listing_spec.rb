require 'rails_helper'

RSpec.describe ProductsListing, type: :model do
  let(:valid_file) do
    fixture_file_upload(Rails.root.join('spec/fixtures/sample.csv'))
  end
  let(:invalid_file) do
    fixture_file_upload(Rails.root.join('spec/fixtures/sample_invalid.csv'))
  end

  it 'can be created with valid data' do
    expect(ProductsListing.new(listing: valid_file)).to be_valid
  end

  it 'is invalid without listing' do
    expect(ProductsListing.new).to be_invalid
  end

  it 'doesn`t work with invalid listings' do
    expect(ProductsListing.new(listing: invalid_file)).to be_invalid
  end
end
