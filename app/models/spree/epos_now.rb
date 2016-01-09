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

  # def self.product(id)
  #   self.get('/api/V2/Product/'+id.to_s)
  # end

  def self.customers
    #https://api.eposnowhq.com/api/V2/Customer?page=
    self.get('/api/V2/Customer', { query: { page: 1} } )
  end
  
end
