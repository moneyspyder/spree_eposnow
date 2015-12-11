# encoding: UTF-8
require 'httparty'

module Spree

  class Eposnow::CustomerType #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]    

    def self.all
      #https://api.eposnowhq.com/api/V2/CustomerType/
      self.get('/api/V2/CustomerType')
    end

  end

end