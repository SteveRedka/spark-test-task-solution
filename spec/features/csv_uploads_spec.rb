require 'rails_helper'

RSpec.feature "Csv uploads", type: :feature do
    let(:user) { FactoryBot.create(:user) }
  scenario 'let user upload products from .csv file' do
  login_as(user, scope: :spree_user)
     # sign_in_as! create(:admin_user)
    # log in
    # go to admin page
    # go to products page
    # click 'Import from .csv'
    # selection pops up
    # hit 'submit'
    # it should redirect to orders page
    # database should have a few extra items
  end
end
