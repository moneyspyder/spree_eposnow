module Spree
  module Admin
    module Eposnow
      class LocationsController < Spree::Admin::BaseController

        def index
          @locations = Spree::Eposnow::Location.all
        end

      end

    end

  end

end