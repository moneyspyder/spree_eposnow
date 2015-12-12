module Spree
  module Admin
    module Eposnow
      class LocationsController < Spree::Admin::BaseController

        def index
          @locations = Spree::Eposnow::Location.all
        end

        def edit
          @location = Spree::Eposnow::Location.find(params[:id])
          #https://api.eposnowhq.com/api/V2/Location/{Location_ID}
        end

        def link
          @location = Spree::Eposnow::Location.find(params[:id])
          stock_location = Spree::StockLocation.find(params[:location_id])
          stock_location.eposnow_location_id = @location['LocationID']
          stock_location.save
          return redirect_to admin_eposnow_locations_path
        end

      end

    end

  end

end