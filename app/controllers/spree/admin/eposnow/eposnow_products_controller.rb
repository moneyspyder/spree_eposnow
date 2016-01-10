module Spree
  module Admin
    module Eposnow
      class EposnowProductsController < Spree::Admin::BaseController

        def index
          params[:page] ||= 1
          @products = Spree::Eposnow::Product.paginate(params[:page])
        end

        # def link
        #   @location = Spree::Eposnow::Location.find(params[:id])
        #   stock_location = Spree::StockLocation.find(params[:location_id])
        #   stock_location.eposnow_location_id = @location['LocationID']
        #   stock_location.save
        #   return redirect_to admin_eposnow_locations_path
        # end

        def show
          @product = Spree::Eposnow::Product.find(params[:id])
        end

        def sync
          @product = Spree::Eposnow::Product.find(params[:id])
          @product.sync
          return redirect_to admin_eposnow_eposnow_product_path(params[:id])
        end

        def sync_all
          page = 1
          @products = Spree::Eposnow::Product.paginate(page)
          product_count = 0
          begin
            @products.each do |x|
              product = Spree::Eposnow::Product.find(x['ProductID'].to_s)
              product.sync
              product_count += 1
            end
            page += 1
            @products = Spree::Eposnow::Product.paginate(page)
          end until @products.length < 200

        end

      end
    end
  end
end