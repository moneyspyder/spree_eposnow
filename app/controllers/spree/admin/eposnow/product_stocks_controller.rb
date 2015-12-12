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
        end

        def update
          @product_stock = Spree::Eposnow::ProductStock.find(params[:id])
          @product_stock.update( params[:eposnow_product_stock] )
          return redirect_to edit_admin_eposnow_product_stock_path( params[:id] )
        end

      end
    end
  end
end