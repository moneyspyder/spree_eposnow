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

end