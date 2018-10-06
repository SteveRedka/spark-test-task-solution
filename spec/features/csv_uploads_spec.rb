require 'rails_helper'

RSpec.feature 'Csv uploads', type: :feature do
  let(:admin) { FactoryBot.create(:admin_user) }
  sample_file_route = Rails.root.join('spec/fixtures/sample.csv')

  scenario 'let user upload products from .csv file' do
    sign_in_as! admin
    visit '/admin/products'
    expect(page.body).to include('Import from .csv')
    attach_file(sample_file_route)
    expect do
      click_on('Import from .csv')
    end.to change { Spree::Product.count }.by(3)
    expect(page).to have_current_path('/admin/products')
  end
end
