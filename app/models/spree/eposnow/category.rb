# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::Category #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

    if Rails.env == 'development'
      debug_output $stdout
    end  
    
    #attr_accessor   


    def self.all
      self.get('/api/V2/Category')
    end

  end

end