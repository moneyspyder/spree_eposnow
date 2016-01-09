require 'rails_helper'

RSpec.describe Spree::Admin::Eposnow::CategoriesController, type: :controller do

  # before do
  #   allow(controller).to receive(:spree_current_user).and_return(nil)
  # end
  before do
    controller.stub spree_current_user: nil
  end  

  #let!(:store) { create(:store, default: true) }

  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock # or :fakeweb
  end

  # TODO Need to set the preferences before the model is loaded
  before(:each) do
    Spree::Config[:eposnow_key] = '2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0'
    Spree::Config[:eposnow_secret] = '868MZR5KHSNQYGVYSYK8N8QN1EV402DG'
  end

  describe 'GET index' do  

    render_views

    stub_authorization!

    it "has a 200 status code" do
      VCR.use_cassette("categories") do
        spree_get :index
      end
      expect(response.status).to eq(200)
    end

  end

  describe 'POST sync' do

    render_views

    stub_authorization!

    it "it creates a category taxonomy" do
      expect{
        VCR.use_cassette("sync_categories") do
          spree_post :sync
        end
      }.to change{
        Spree::Taxonomy.count
      }.from(0).to(1)
    end

    it "it creates a taxon" do
      expect{
        VCR.use_cassette("sync_categories") do
          spree_post :sync
        end
      }.to change{
        Spree::Taxon.count
      }.from(0).to(2)
    end

    it "it creates a taxon" do
      expect{
        VCR.use_cassette("sync_categories_with_parent") do
          spree_post :sync
        end
      }.to change{
        Spree::Taxon.count
      }.from(0).to(3)
    end    

  end  

end