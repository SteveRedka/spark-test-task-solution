require 'rails_helper'

RSpec.describe Products::ProductCreator do
  let(:valid_row) do
    { 'name': 'Ruby on Rails Bag',
      'description': 'Animi officia aut amet molestiae atque',
      'price': '22.99',
      'available_on': '2017-12-04T14:55:22.913Z',
      'slug': 'ruby-on-rails-bag',
      'stock_items': '5',
      'category': 'Bags' }
  end

  it 'stops peacefully on empty rows' do
    # I think it should raise error, but task specs list this case as valid
    valid_row[:name] = ''
    expect do
      Products::ProductCreator.new(valid_row).call
    end.to change { Spree::Product.count }.by(0)
  end

  it 'creates a product with valid data' do
    expect do
      Products::ProductCreator.new(valid_row).call
    end.to change { Spree::Product.count }.by(1)
  end

  it 'handles all rows' do
    Products::ProductCreator.new(valid_row).call
    @product = Spree::Product.last
    expect(@product.name).to eq(valid_row[:name])
    expect(@product.description).to eq(valid_row[:description])
    expect(@product.price.to_s).to eq(valid_row[:price])
    expect(@product.available_on).to eq(valid_row[:available_on])
    expect(@product.slug).to eq(valid_row[:slug])
    expect(@product.total_on_hand).to eql(valid_row[:stock_items].to_i)
    expect(@product.category.name).to eq(valid_row[:category])
  end

  it 'handles comma in price' do
    valid_row[:price] = '22,99'
    Products::ProductCreator.new(valid_row).call
    @product = Spree::Product.last
    expect(@product.price.to_s).to eq('22.99')
  end
end
