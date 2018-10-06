require 'rails_helper'

RSpec.describe Csv::CsvImporter do
  let(:file) { File.open(Rails.root.join('spec/fixtures/sample.csv')) }

  it 'processes sample file' do
    expect do
      Csv::CsvImporter.new(file).call
    end.to change { Spree::Product.count }.by(3)
  end
end
