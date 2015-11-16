require 'rails_helper'

RSpec.describe Spree::EposNow, type: :model do

  describe '#token' do

    context 'key is "2ED26E1T7HWALCAR2P8CCJEEPUPVOLF4"' do

      let(:key) { '2ED26E1T7HWALCAR2P8CCJEEPUPVOLF4' }

      context 'secret is "868MZR5IDCNBYGVYSIK2N2QN3EV409RR"' do

        let(:secret) { '868MZR5IDCNBYGVYSIK2N2QN3EV409RR' }

        it 'is "MkVEMjZFMVQ3SFdBTENBUjJQOENDSkVFUFVQVk9MRjQ6ODY4TVpSNUlEQ05C\nWUdWWVNJSzJOMlFOM0VWNDA5UlI="' do
          Spree::EposNow.new(key, secret).token.should == %Q{
MkVEMjZFMVQ3SFdBTENBUjJQOENDSkVFUFVQVk9MRjQ6ODY4TVpSNUlEQ05C\nWUdWWVNJSzJOMlFOM0VWNDA5UlI=
}.lstrip
        end

      end
      
    end

  end

  describe '.products' do

    VCR.configure do |config|
      config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
      config.hook_into :webmock # or :fakeweb
    end

    #Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]
    before(:each) do
      Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
      Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
    end

    it 'returns 6 products' do
      VCR.use_cassette("products") do
        Spree::EposNow.products.length.should == 6
      end
      
    end

  end

end