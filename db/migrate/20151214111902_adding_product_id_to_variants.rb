class AddingProductIdToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :eposnow_product_id, :integer, default: nil
    add_index :spree_variants, :eposnow_product_id    
  end
end
