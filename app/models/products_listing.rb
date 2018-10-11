# Holds lists of products to create, usually in form of .CSV files.
class ProductsListing < ApplicationRecord
  has_one_attached :listing
  validates :listing, attached: true, presence: true,
                      content_type: ['text/plain', 'text/csv']
  validates_with ProductsListingValidator
end
