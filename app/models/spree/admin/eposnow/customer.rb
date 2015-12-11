# encoding: UTF-8

require 'active_resource'

class Spree::Admin::Eposnow::Customer #< ActiveResource::Base
  include ActiveModel::Model
  #self.site = "https://api.eposnowhq.com"
  include HTTParty

  base_uri 'https://api.eposnowhq.com'
  headers "Content-Type" => "application/json"

  basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

  if Rails.env == 'development'
    debug_output $stdout
  end  
  
  attr_accessor :Forename, :Surname

  def self.create(attrs = {})
    self.post(
      '/api/V2/Customer/', 
      { 
        :Title => 0,
        :Forename => "Mr Ex",
        :Surname => "Pired"
      }
    )
  end

end
