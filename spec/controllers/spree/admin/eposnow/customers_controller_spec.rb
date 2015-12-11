require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::CustomersController, type: :controller do

  # before do
  #   allow(controller).to receive(:spree_current_user).and_return(nil)
  # end
  before do
    controller.stub spree_current_user: nil
  end  

  #let!(:store) { create(:store, default: true) }

  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock # or :fakeweb
  end

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end

  describe 'GET index' do  

    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("customers") do
        spree_get :index
      end
      expect(response.status).to eq(200)
    end

  end  

  describe 'GET new' do  
    render_views

    stub_authorization!

    it "has a 200 status code" do
      spree_get :new
      expect(response.status).to eq(200)
    end

  end

  describe 'POST create' do  

    render_views

    stub_authorization!

    context 'with invalid request' do

      it "has a 200 status code" do
        VCR.use_cassette("fail_to_create_customer") do
          spree_post :create
        end
        expect(response).to render_template("new")
      end

    end

  end      

end
