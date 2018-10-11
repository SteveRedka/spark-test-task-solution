class ProductsImporterJob < ApplicationJob
  require 'csv'
  queue_as :default

  def perform(products_listing)
    listing = products_listing.listing
    path_to_file = ActiveStorage::Blob.service.send(:path_for, listing.key)
    @file = File.open(path_to_file)

    CSV.foreach(@file, headers: :first_row, col_sep: ';') do |row|
      Products::ProductCreator.new(row.to_h.symbolize_keys).call
    end
  end
end
