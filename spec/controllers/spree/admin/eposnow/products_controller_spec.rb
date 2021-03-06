require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::ProductsController, type: :controller do

  before do
    controller.stub spree_current_user: nil
  end

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
    Spree::Eposnow::Product.basic_auth(Spree::Config[:eposnow_key],Spree::Config[:eposnow_secret])
  end

  describe 'GET index' do  

    render_views

    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("products") do
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

  describe 'GET show' do

    render_views
    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("product_show") do
        spree_get :show, id: '1163871'
      end
      expect(response.status).to eq(200)
    end

  end  

  describe 'POST create' do

    let(:params) do
{"Name"=>"Test Product",
   "CostPrice"=>"5.95 ",
   "SalePrice"=>"16.95 ",
   "EatOutPrice"=>"16.95 ",
   "ProductID"=>"",
   "Description"=>"",
   "CategoryID"=>"",
   "Barcode"=>"",
   "TaxRateID"=>"",
   "EatOutTaxRateID"=>"",
   "Sku"=>"2384092342",
   "BrandID"=>"",
   "SupplierID"=>"",
   "PopupNoteID"=>"",
   "UnitOfSale"=>"",
   "VolumeOfSale"=>"",
   "MultiChoiceID"=>"",
   "ColourID"=>"",
   "VariantGroupID"=>"",
   "Size"=>"",
   "OrderCode"=>"",
   "ButtonColourID"=>"",
   "SellOnWeb"=>"true",
   "SellOnTill"=>"false"}
    end

    render_views
    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("create_product") do
        spree_post :create, eposnow_product: params
      end
      expect(response.status).to eq(302)
    end    

  end

end