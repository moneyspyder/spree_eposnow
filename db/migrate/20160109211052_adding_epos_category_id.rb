class AddingEposCategoryId < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :eposnow_category_id, :integer, default: nil
    add_index :spree_taxons, :eposnow_category_id        
  end
end
