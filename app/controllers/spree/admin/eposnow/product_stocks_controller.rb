module Spree
  module Admin
    module Eposnow
      class ProductStocksController < Spree::Admin::BaseController

        def index
          params[:page] ||= 1
          @product_stocks = Spree::Eposnow::ProductStock.paginate(params[:page])
        end

        def edit
          @product_stock = Spree::Eposnow::ProductStock.find(params[:id])
          @variant = Spree::Variant.find_by_eposnow_product_id(@product_stock.ProductID)
          @stock_location = @variant.stock_locations.where(eposnow_location_id: @product_stock.LocationID)
        end

        def update
          @product_stock = Spree::Eposnow::ProductStock.find(params[:id])
          @product_stock.update( params[:eposnow_product_stock] )
          return redirect_to edit_admin_eposnow_product_stock_path( params[:id] )
        end

        def sync_all
          @product_stocks = Spree::Eposnow::ProductStock.paginate(1)

          @product_stocks.each do |product_stock|
            variant = Spree::Variant.find_by_eposnow_product_id(product_stock['ProductID'])
            next unless variant
            stock_location = variant.stock_locations.where(eposnow_location_id: product_stock['LocationID'])
            next unless stock_location
            # Spree::StockItem
            #binding.pry
            stock_item = stock_location.first.stock_items.where(variant:variant).first_or_initialize

            stock_item.set_count_on_hand product_stock['CurrentStock'] >= 0 ? product_stock['CurrentStock'] : 0
            stock_item.eposnow_product_stock_id = product_stock['StockID']


            puts stock_item.inspect
            #stock_movement = stock_location.stock_movements.build(stock_movement_params)
            #stock_movement.stock_item = stock_location.set_up_stock_item(variant)            
            #puts stock_location.inspect
          end
          return redirect_to admin_eposnow_product_stocks_path
        end

      end
    end
  end
end