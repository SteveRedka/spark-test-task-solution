module Csv
  class CsvImporter < ApplicationController
    require 'csv'

    SHIPPING_CATEGORY = Spree::ShippingCategory.find_by(name: 'Default')
    LOCATION_NAME = 'default'

    def initialize(file, modl: 'Product')
      @file = file
      @model = modl
    end

    def call
      byebug
      raise ArgumentError, "Can`t handle class #{@model}" if @model != 'Product'

      # CSV.foreach(@file, headers: :first_row, col_sep: ';') do |row|
      #   Csv::Products::ProductCreator.new(row).call
      # end
    end

    private

    # def valid?
    #   record_attributes = read_stuff_from_csv
    #   import_records = record_attributes.map {|attrs| Spree::Product.new(attrs)}
    #   import_records.map(&:valid?).all?
    # end
  end
end
