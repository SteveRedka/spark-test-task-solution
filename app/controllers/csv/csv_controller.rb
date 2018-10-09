module Csv
  class CsvController < Spree::Admin::BaseController
    include Spree::Core::Engine.routes.url_helpers
    def process_products
      @file = params['csv-file'].open
      if Csv::CsvImporter.new(@file).call
        flash[:success] = 'Products created'
      else
        flash[:error] = 'Something went wrong'
      end
      redirect_to admin_products_path
    end
  end
end
