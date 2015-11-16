# encoding: UTF-8
require 'httparty'

class Spree::EposNow
  include HTTParty

  # preference :api_key, :string
  # preference :api_secret, :string

  base_uri 'https://api.eposnowhq.com'
  headers "Content-Type" => "application/json"
  #basic_auth "2ND36E1H9HWAMCAR2P8QCJFGPUQVOLF0", "868MZR5KHSNQYGVYSYK8N8QN1EV402DG"
  basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]
  #default_params :output => 'json'

  #if Rails.env == 'development'
    debug_output $stdout
  #end


  def initialize(key,secret)
    @key, @secret = key, secret
  end

  def token
    Base64.encode64(@key+':'+@secret)
  end

  def self.products
    self.get('/api/V2/Product', { query: { page: 1 } } )
  end

  def self.product(id)
    self.get('/api/V2/Product/'+id.to_s)
  end
  
end
