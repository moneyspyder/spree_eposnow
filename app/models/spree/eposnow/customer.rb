# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::Customer #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

    if Rails.env == 'development'
      debug_output $stdout
    end  
    
    attr_accessor   :Title, :Forename, :Surname, :BusinessName, :DateOfBirth, :MainAddressID,
                    :ContactNumber, :ContactNumber2, :EmailAddress, :Type,
                    :MaxCredit, :CurrentBalance, :CurrentBalance, :ExpiryDate,
                    :CardNumber, :CurrentPoints, :SignUpDate, :Notes

    def self.create(attrs = {})
      self.post(
        '/api/V2/Customer/', 
        {
          :body => { 
            :Title => 0,
            :Forename => "Mr Ex",
            :Surname => "Pired" ,
            :BusinessName => nil,
            :DateOfBirth => nil,
            :MainAddressID => 1,
            :ContactNumber => "09876543987",
            :ContactNumber2 => "98765439876",
            :EmailAddress => "made@up.com",
            :Type => 4187,
            :MaxCredit => 0,
            :CurrentBalance => 0,
            :ExpiryDate => "2013-01-17T00:00:00",
            :CardNumber => "%0003?;1236?",
            :CurrentPoints => 0,
            :SignUpDate => "2013-03-12T11:40:49.323",
            :Notes => nil
          }.to_json
        }
      )
    end

  end

end