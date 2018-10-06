module Products
  # Takes in hash;
  # makes products and all related models from it
  class ProductCreator < ApplicationController
    SHIPPING_CATEGORY = Spree::ShippingCategory.find_or_create_by(name: 'Default').freeze
    LOCATION_NAME = 'default'.freeze

    def initialize(row)
      @row = row.to_h.except(nil)
    end

    def call
      return if empty_row?(@row)

      categories = Spree::Taxonomy.find_or_create_by(name: 'Categories')
      category = categories.taxons.find_or_create_by(name: @row[:category])
      location = Spree::StockLocation.find_or_create_by(name: LOCATION_NAME)

      product = category.products.new(name: @row[:name],
                                      description: @row[:description],
                                      available_on: @row[:available_on],
                                      slug: @row[:slug],
                                      shipping_category: SHIPPING_CATEGORY)
      formatted_price = @row[:price].gsub(/,/, '.')
      product.price = formatted_price
      product.save!

      category.products << product
      default_variant = product.variants.find_or_create_by(is_master: true)
      @stock = default_variant.stock_items
                              .find_or_create_by(variant: default_variant,
                                                 stock_location: location)
      @stock.count_on_hand += @row[:stock_items].to_i
      @stock.save
    end

    private

    def empty_row?(row)
      row[:name].empty?
    end
  end
end
