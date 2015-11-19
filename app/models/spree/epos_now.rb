# encoding: UTF-8
require 'httparty'

class Spree::EposNow
  include HTTParty

  base_uri 'https://api.eposnowhq.com'
  headers "Content-Type" => "application/json"

  basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

  if Rails.env == 'development'
    debug_output $stdout
  end

  def self.products
    self.get('/api/V2/Product', { query: { page: 1 } } )
  end

  def self.product(id)
    self.get('/api/V2/Product/'+id.to_s)
  end
  
end
