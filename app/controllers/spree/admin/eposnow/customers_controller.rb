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
          response = Eposnow::Customer.create(params[:admin_eposnow_customer])
          if response.code == 400
            @customer = Eposnow::Customer.new(params[:admin_eposnow_customer])
            @customer.errors.add(:base, response.to_s)
            return render :new
          end
        end

      end

    end

  end

end