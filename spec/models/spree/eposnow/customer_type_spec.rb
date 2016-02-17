require 'rails_helper'

RSpec.describe Spree::Eposnow::CustomerType, type: :model do

  VCR.configure do |config|
    config.cassette_library_dir = File.join( SpreeEposnow::Engine.root, "spec/fixtures/vcr_cassettes" )
    config.hook_into :webmock # or :fakeweb
  end

  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end    
  
  describe '.all' do

    it "doesn't raise an error" do
      VCR.use_cassette("customer_types") do
    
      expect{
        Spree::Eposnow::CustomerType.all
      }.not_to raise_error

      end

    end

  end


end
