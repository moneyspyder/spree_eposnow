require 'rails_helper'

RSpec.describe Spree::Eposnow::ProductStock, type: :model do

  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
    Spree::Eposnow::ProductStock.basic_auth(Spree::Config[:eposnow_key],Spree::Config[:eposnow_secret])
  end    
  
  describe '.paginate' do

    it "doesn't raise an error" do
      VCR.use_cassette("product_stocks") do
    
      expect{
        Spree::Eposnow::ProductStock.paginate
      }.not_to raise_error

      end

    end

  end

  describe '#set_count_on_hand' do

    let(:product_stock) do
      Spree::Eposnow::ProductStock.new(
        {
          "StockID" => 431656,"LocationID" => 4230, "ProductID" => 1163872,
          "CurrentStock" => 10,"MinStock" => 5,"MaxStock" => 100,"CurrentVolume" => 0,
          "OnOrder" => 20, "Alerts" => false
        }
      )
    end

    describe 'changing stock level to "30"' do

      it "doesn't raise an error" do
        VCR.use_cassette("product_stock_set_count_on_hand") do
          expect{
            product_stock.set_count_on_hand(30)
          }.not_to raise_error
        end
      end

    end

  end

end