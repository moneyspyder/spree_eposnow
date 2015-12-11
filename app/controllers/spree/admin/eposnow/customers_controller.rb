module Spree
  module Admin
    module Eposnow
      class CustomersController < Spree::Admin::BaseController

        def new
        end

        def index
          @customers =  Spree::EposNow.customers.collect do |x| 
                          x.slice("Forename", "Surname", "EmailAddress", "ContactNumber")
                        end          
        end

      end
    end

  end

end