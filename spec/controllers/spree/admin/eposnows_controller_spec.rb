require 'rails_helper'

RSpec.describe Spree::Admin::EposnowsController, type: :controller do

  # before do
  #   allow(controller).to receive(:spree_current_user).and_return(nil)
  # end
  before do
    controller.stub spree_current_user: nil
  end  

  #let!(:store) { create(:store, default: true) }

  VCR.configure do |config|
    #config.cassette_library_dir = File.join(Flexshop::Engine.root, "test/fixtures/vcr_cassettes")
    config.cassette_library_dir = File.join( SpreeEposnow::Engine.root, "spec/fixtures/vcr_cassettes" )
    config.hook_into :webmock # or :fakeweb
  end

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end

end