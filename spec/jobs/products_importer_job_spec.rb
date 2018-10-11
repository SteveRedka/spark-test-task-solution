require 'rails_helper'

RSpec.describe ProductsImporterJob, type: :job do
  include ActiveJob::TestHelper
  let(:products_listing) { FactoryBot.create :products_listing }

  it 'creates products from valid product listings' do
    expect do
      ProductsImporterJob.perform_now(products_listing)
    end.to change { Spree::Product.count }.by(3)
  end
end
