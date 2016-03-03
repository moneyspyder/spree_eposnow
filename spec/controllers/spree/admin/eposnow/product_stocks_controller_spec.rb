require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::ProductStocksController, type: :controller do

  # before do
  #   allow(controller).to receive(:spree_current_user).and_return(nil)
  # end
  before do
    controller.stub spree_current_user: nil
  end  

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
    Spree::Eposnow::ProductStock.basic_auth(Spree::Config[:eposnow_key],Spree::Config[:eposnow_secret])
    Spree::Eposnow::Product.basic_auth(Spree::Config[:eposnow_key],Spree::Config[:eposnow_secret])
  end

  describe 'GET index' do  
    render_views
    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("product_stocks") do
        spree_get :index
      end
      expect(response.status).to eq(200)
    end

  end

  describe 'POST sync_all' do
    render_views
    stub_authorization!

    it "redirects to the product stock page" do
      VCR.use_cassette("product_stocks_sync_all") do
        spree_post :sync_all
      end
      expect(response.status).to eq(302)
    end

    let(:shipping_category) { Spree::ShippingCategory.create(name: 'Default') }

    let(:stock_location) do
      Spree::StockLocation.create(name: 'Warehouse', eposnow_location_id: 4230)
    end

    let(:variant) do
      product = Spree::Product.create(
        name: 'Example Product', 
        price: 16.88, 
        shipping_category: shipping_category
      )
      result = product.master
      result.update_attributes(eposnow_product_id: 1163872)
      result
    end

    context 'stock level on ePosnow is 25' do

      context 'there is an existing product with the current volume 6' do

        let(:stock_item) do
          variant.stock_items.create(stock_location: stock_location, variant_id: variant)
          sl = Spree::StockItem.last
          sl.set_count_on_hand(6)
          sl
        end

        before(:each) { stock_item }

        it 'changes the StockItem#count_on_hand to 6' do
          VCR.use_cassette("product_stocks_sync_all") do
            expect{
              spree_post :sync_all
            }.to change{
              Spree::StockItem.find(stock_item).count_on_hand
            }.from(6).to(25)
          end
        end          

      end

      context 'there is an existing product' do

        before(:each) { variant; stock_location }

        it 'sets the epos_product_stock_id' do
          VCR.use_cassette("product_stocks_sync_all") do
            expect{
              spree_post :sync_all
            }.to change{
              Spree::StockItem.last.eposnow_product_stock_id
            }.from(nil).to(431656)
          end
        end

      end

    end

  end

end
