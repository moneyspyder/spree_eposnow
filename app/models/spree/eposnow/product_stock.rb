# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::ProductStock #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

    if Rails.env == 'development'
      debug_output $stdout
    end

    attr_accessor   :StockID, :LocationID, :ProductID, :CurrentStock, :MinStock,
                    :MaxStock, :CurrentVolume, :OnOrder, :Alerts

    def self.paginate(page_no = 1)
      self.get(
        '/api/V2/ProductStock/',
        { query: { page: page_no } } 
      )
      #https://api.eposnowhq.com/api/V2/ProductStock?page={Page_No}
    end

    def self.find(id)
      response = self.get('/api/V2/ProductStock/'+id )
      self.new response.to_hash
    end

    def update(attr = {})
      response = self.class.put(
        '/api/V2/ProductStock/'+self.StockID.to_s,
        {
          :body => attr.to_json
        }        
      )
    end

    def self.index_keys
      keys - [:StockID]
    end

    def self.keys
      [
        :StockID, :LocationID, :Product, :CurrentStock, :MinStock,
        :MaxStock, :CurrentVolume, :OnOrder, :Alerts
      ]      
    end

    def keys
      [
        :StockID, :LocationID, :ProductID, :CurrentStock, :MinStock,
        :MaxStock, :CurrentVolume, :OnOrder, :Alerts
      ]
    end

  end
end