require 'rails_helper'

RSpec.describe Spree::EposNow, type: :model do

  # TODO Drop this model
  
  # describe '.products' do

  #   VCR.configure do |config|
  #     config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  #     config.hook_into :webmock # or :fakeweb
  #   end

  #   # TODO Need to set the preferences before the model is loaded
  #   before(:each) do
  #     Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
  #     Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  #   end

  #   it 'returns 6 products' do
  #     VCR.use_cassette("products") do
  #       Spree::EposNow.products.length.should == 6
  #     end
      
  #   end

  # end

end