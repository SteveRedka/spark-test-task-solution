class CsvController < ActionController::Base
  include Spree::Core::Engine.routes.url_helpers
  def batch_process
    @file = params['csv-file'].open
    Csv::CsvImporter.new(@file).call
    flash[:success] = 'Products created'
    redirect_to admin_products_path
  end
end
