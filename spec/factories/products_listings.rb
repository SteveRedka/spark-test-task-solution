FactoryBot.define do
  factory :products_listing do
    after :build do |products_listing|
      file_path = Rails.root.join('spec/fixtures/sample.csv')
      file = fixture_file_upload(file_path, 'text/csv')
      products_listing.listing.attach(file)
    end
  end
end
