require 'rails_helper'

RSpec.describe Csv::CsvController, type: :controller do
  let(:file) do
    fixture_file_upload(Rails.root.join('spec/fixtures/sample.csv'))
  end
  let(:invalid_file) do
    fixture_file_upload(Rails.root.join('spec/fixtures/sample_invalid.csv'))
  end
  let(:admin) { FactoryBot.create(:admin_user) }

  it 'requires to be logged in as admin' do
    expect do
      post :process_products, params: { 'csv-file': file }
    end.to change { Spree::Product.count }.by(0)
  end

  context 'as admin' do
    before do
      sign_in admin
    end

    it 'creates products from sample file' do
      expect do
        post :process_products, params: { 'csv-file': file }
      end.to change { Spree::Product.count }.by(3)
    end

    it 'handles invalid cases without crashing' do
      post :process_products, params: { 'csv-file': invalid_file }
      expect(response.status).to eq(302)
    end
  end
end
