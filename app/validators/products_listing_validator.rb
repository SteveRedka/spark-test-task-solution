class ProductsListingValidator < ActiveModel::Validator
  VALID_HEADER = ';name;description;price;availability_date;slug;stock_total;category'

  def validate(record)
    @record = record
    @listing = @record.listing.attachment&.blob&.download

    if @listing
      check_listing_header(@listing)
    end
  end

  private

  def check_listing_header(listing)
    rows = listing.split("\n")
    if rows[0] != VALID_HEADER
      @record.errors[:listing] << 'listing header is invalid'
    end
  end
end
