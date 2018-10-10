class AddTokenToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_orders, :token, :string
  end
end
