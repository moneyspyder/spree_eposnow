require 'rails_helper'

RSpec.describe Spree::Admin::EposnowsController, type: :controller do

  describe 'GET products' do    

    it "doesn't raise an error" do
      expect{
        get :products
      }.not_to raise_error
    end

  end

end
