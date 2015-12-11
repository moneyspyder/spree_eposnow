require 'rails_helper'

RSpec.describe Eposnow::CustomerType, type: :model do
  
  describe '.all' do

    it "doesn't raise an error" do
      expect{
        Eposnow::CustomerType.all
      }.not_to raise_error
    end

  end


end
