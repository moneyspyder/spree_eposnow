module Spree
  module Admin
    module Eposnow
      class ProductStocksController < Spree::Admin::BaseController

        def index
          params[:page] ||= 1
          @product_stocks = Spree::Eposnow::ProductStock.paginate(params[:page])
        end

      end
    end
  end
end