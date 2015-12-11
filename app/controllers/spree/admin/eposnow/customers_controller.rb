module Spree
  module Admin
    module Eposnow
      class CustomersController < Spree::Admin::BaseController

        def new
          @customer = Eposnow::Customer.new
        end

        def index
          @customers =  Spree::EposNow.customers.collect do |x| 
                          x.slice("Forename", "Surname", "EmailAddress", "ContactNumber")
                        end          
        end

        def create
          #customer = Eposnow::Customer.new(params[:admin_eposnow_customer])
          #binding.pry
          if Eposnow::Customer.create(params[:admin_eposnow_customer])
            #binding.pry
            raise StandardError.new('IT WORKS')
            
          end
        end

      end
    end

  end

end