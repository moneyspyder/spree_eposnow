# encoding: UTF-8
require 'httparty'

class Spree::Admin::Eposnow::CustomerType #< ActiveResource::Base
  include ActiveModel::Model
  #self.site = "https://api.eposnowhq.com"
  include HTTParty

end