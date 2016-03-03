require 'rails_helper'

RSpec.describe Spree::Eposnow::Location do

  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end    
  
  describe '.all' do

    it "doesn't raise an error" do
      VCR.use_cassette("locations") do
        expect{
          Spree::Eposnow::Location.all
        }.not_to raise_error
      end
    end

  end


end