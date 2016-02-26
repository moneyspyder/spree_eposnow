require 'rails_helper'

RSpec.describe Spree::Eposnow::Product do

  VCR.configure do |config|
    config.cassette_library_dir = File.join( SpreeEposnow::Engine.root, "spec/fixtures/vcr_cassettes" )
    config.hook_into :webmock # or :fakeweb
  end

  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end    
  
  describe '#sync' do

    context 'has "ProductId" "4" ' do

      context 'has barcode "1567634452"' do 

        let(:eposnow_product) do
          Spree::Eposnow::Product.new(
            {
              'ProductID' => 4, 
              'Name' => 'Artisan Coffee Table ',
              'CostPrice' => 200.0,
              'SalePrice' => 495.0,
              'Description' => 'Artisan Coffee Table',
              'Barcode' => '1567634452'
            }
          )
        end
 
        context 'variant exists with SKU "1567634452"' do

          let(:variant) do
            FactoryGirl.create(:master_variant, sku: "1567634452")
          end

          it 'changes eposnow_product_id to "4"' do
            expect{
              eposnow_product.sync
            }.to change{
              Spree::Variant.find(variant).eposnow_product_id
            }.from(nil).to(4)
          end

        end

      end

    end

  end

end