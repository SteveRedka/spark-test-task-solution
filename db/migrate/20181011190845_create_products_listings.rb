class CreateProductsListings < ActiveRecord::Migration[5.2]
  def change
    create_table :products_listings do |t|

      t.timestamps
    end
  end
end
