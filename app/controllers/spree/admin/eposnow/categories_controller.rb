module Spree
  module Admin
    module Eposnow
      class CategoriesController < Spree::Admin::BaseController

        def index
          @categories = Spree::Eposnow::Category.all
          # @categories =  Spree::EposNow.customers.collect do |x| 
          #                 x.slice("Forename", "Surname", "EmailAddress", "ContactNumber")
          #               end          
        end

      end

    end

  end

end

# * Kitchen Bed & Bath  
# * Gifts Jewellery & Stationery
# * Delivery
# * Home Accessories
# * Lighting
# * Furniture