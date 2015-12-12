class AddingEposnowLocationToLocation < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :eposnow_location_id, :integer, default: nil
    add_index :spree_stock_locations, :eposnow_location_id
  end
end
