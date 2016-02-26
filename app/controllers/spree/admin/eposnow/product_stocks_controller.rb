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

          # TODO This is duplicated with the sync RakeTask
          link_with_eposnow

          @product_stocks = Spree::Eposnow::ProductStock.paginate(1)
          
          @product_stocks.each do |product_stock|
            
            variant = Spree::Variant.find_by_eposnow_product_id(product_stock['ProductID'])
            next unless variant
            stock_location = variant.stock_locations.where(eposnow_location_id: product_stock['LocationID']).first
            next unless stock_location
            # Spree::StockItem
            stock_item = stock_location.stock_items.where(variant:variant).first_or_initialize

            stock_item.eposnow_product_stock_id = product_stock['StockID']
            stock_item.set_count_on_hand product_stock['CurrentStock'] >= 0 ? product_stock['CurrentStock'] : 0
          end
          return redirect_to admin_eposnow_product_stocks_path
        end

      protected

        def link_with_eposnow
          results = []
          page = 1
          until (@products = Spree::Eposnow::Product.paginate(page)).empty?
            @products.each do |x|
              sku = x.Barcode
              next if sku.nil?
              next if sku.blank?
              v = Spree::Variant.find_by_sku(sku)
              next if v.nil?
              if v.eposnow_product_id.nil?
                product_id = x.ProductID.to_i
                v.eposnow_product_id = product_id
                v.save
                results << v.product.name
              end
            end  
            page +=1
          end
        end        

      end

    end
    
  end

end