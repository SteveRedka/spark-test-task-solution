module Csv
  class CsvImporter < ApplicationController
    require 'csv'

    def initialize(file, modl: 'Product')
      @file = file
      @model = modl
    end

    def call
      raise ArgumentError, "Can`t handle class #{@model}" if @model != 'Product'

      CSV.foreach(@file, headers: :first_row, col_sep: ';') do |row|
        Products::ProductCreator.new(row.to_h.symbolize_keys).call
      end

      true
    end
  end
end
