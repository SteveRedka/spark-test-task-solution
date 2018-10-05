require 'rails_helper'

RSpec.feature "Csv uploads", type: :feature do
  let(:admin) { FactoryBot.create(:admin_user) }
  scenario 'let user upload products from .csv file' do
    sign_in_as! admin
    visit '/admin/products'
    expect(page.body).to include('Import from .csv')
    attach_file('Image', '/path/to/image.jpg')
    expect do
      click_on('Import from .csv')
    end.to inclrease { Spree::Product.count }.by(3)
    expect(page).to have_current_path('/admin/products')
  end
end
