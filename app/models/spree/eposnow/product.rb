# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::Product #< ActiveResource::Base
    include ActiveModel::Model
    #self.site = "https://api.eposnowhq.com"
    include HTTParty

    base_uri 'https://api.eposnowhq.com'
    headers "Content-Type" => "application/json"

    basic_auth Spree::Config[:eposnow_key], Spree::Config[:eposnow_secret]

    if Rails.env == 'development'
      debug_output $stdout
    end  
    
    attr_accessor   :ProductID, :Name, :Description, :CostPrice, :SalePrice, :EatOutPrice,
                    :CategoryID, :Barcode, :TaxRateID, :EatOutTaxRateID, :Sku,
                    :SellOnWeb, :SellOnTill, :BrandID, :SupplierID, :PopupNoteID,
                    :UnitOfSale, :VolumeOfSale, :MultiChoiceID, :ColourID,
                    :VariantGroupID, :Size, :OrderCode, :ButtonColourID,
                    :SortPosition, :MagentoAttributeSetID, :RRPrice,
                    :CostPriceTaxRateID, :ProductType, :TareWeight, :ArticleCode


    def self.paginate(page_no = 1)
      #https://api.eposnowhq.com/api/V2/Product?page={Page_No}
      self.get(
        '/api/V2/Product',
        { query: { page: page_no } } 
      )
      #https://api.eposnowhq.com/api/V2/ProductStock?page={Page_No}
    end

    def self.find(id)
      response = self.get('/api/V2/Product/'+id )
      self.new response.to_hash      
    end

    def sync
      variant = Spree::Variant.find_by_sku(self.Sku)
      
      if Spree::Variant.find_by_sku(self.Sku)

      else

        product = Spree::Product.new
        product.name = self.Name
        product.description = self.Description
        product.shipping_category = Spree::ShippingCategory.first
        product.sku = self.Sku
        product.cost_price = self.CostPrice
        product.save

        product.master.price = Money.new(self.SalePrice)
        product.master.eposnow_product_id  = self.ProductID
        product.save

        # TODO Don't like this need to add a frontend and backend availability
        unless self.SellOnWeb
          product.available_on = Time.zone.now+100.years
        end

        Spree::Price.create(
          variant_id: product.master.id,
          amount: Money.new(self.SalePrice).cents/100.00,
          currency: 'GBP'
        )
          
      end
    end

    def keys
      [
        :ProductID, :Name, :Description, :CostPrice, :SalePrice, :EatOutPrice,
        :CategoryID, :Barcode, :TaxRateID, :EatOutTaxRateID, :Sku,
        :SellOnWeb, :SellOnTill, :BrandID, :SupplierID, :PopupNoteID,
        :UnitOfSale, :VolumeOfSale, :MultiChoiceID, :ColourID,
        :VariantGroupID, :Size, :OrderCode, :ButtonColourID
      ]
    end

  end

end