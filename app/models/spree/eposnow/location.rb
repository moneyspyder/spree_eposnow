# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::Location #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

    if Rails.env == 'development'
      debug_output $stdout
    end

    attr_accessor   :LocationID, :LocationAreaID, :Name, :BusinessName, :Description,
                    :Address1, :Address2, :Town, :County, :PostCode, :EmailAddress

    def self.all
      self.get('/api/V2/Location')
    end

    def self.find(id)
      self.get('/api/V2/Location/'+id)
    end

  end

end