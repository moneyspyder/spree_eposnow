require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::LocationsController do

  before do
    controller.stub spree_current_user: nil
  end  

  #let!(:store) { create(:store, default: true) }

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
    Spree::Eposnow::Location.basic_auth(Spree::Config[:eposnow_key],Spree::Config[:eposnow_secret])
  end

  describe 'GET index' do  

    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("locations") do
        spree_get :index
      end
      expect(response.status).to eq(200)
    end

  end

  describe 'GET edit' do

    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("edit_location") do
        spree_get :edit, id: 4230
      end
      expect(response.status).to eq(200)
    end    

  end

end
