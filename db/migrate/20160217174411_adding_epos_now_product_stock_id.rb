class AddingEposNowProductStockId < ActiveRecord::Migration
  def change
    add_column :spree_stock_items, :eposnow_product_stock_id, :integer, default: nil
    add_index :spree_stock_items, :eposnow_product_stock_id    
  end
end
