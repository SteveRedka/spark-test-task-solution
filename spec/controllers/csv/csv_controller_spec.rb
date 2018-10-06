require 'rails_helper'

RSpec.describe Csv::CsvController, type: :controller do
  let(:file) do
    fixture_file_upload(Rails.root.join('spec/fixtures/sample.csv'))
  end
  let(:admin) { FactoryBot.create(:admin_user) }

  it 'creates products from sample file' do
    sign_in admin
    expect do
      post :process_products, params: { 'csv-file': file }
    end.to change { Spree::Product.count }.by(3)
  end

  it 'requires to be logged in as admin' do
    expect do
      post :process_products, params: { 'csv-file': file }
    end.to change { Spree::Product.count }.by(0)
  end
end
