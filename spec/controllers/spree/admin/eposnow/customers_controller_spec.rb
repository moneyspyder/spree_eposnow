require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::CustomersController, type: :controller do

  before do
    controller.stub spree_current_user: nil
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

      it "renders the new template" do
        VCR.use_cassette("fail_to_create_customer") do
          spree_post :create
        end
        expect(response).to render_template("new")
      end

    end

    context 'with successful response' do

      it "redirects to the index page" do
        VCR.use_cassette("create_customer") do
          spree_post :create
        end
        expect(response).to redirect_to(admin_eposnow_customers_path)
      end

    end

  end      

end
