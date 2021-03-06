# encoding: UTF-8
require 'httparty'
module Spree
  
  class Eposnow::Product #< ActiveResource::Base
    include ActiveModel::Model
    include ActiveModel::Validations

    validates :Name, length: { maximum: 28 }
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
      ).collect { |x| self.new(x) } 
      #https://api.eposnowhq.com/api/V2/ProductStock?page={Page_No}
    end

    def self.find(id)
      response = self.get('/api/V2/Product/'+id )
      self.new response.to_hash      
    end

    def create
      return false unless self.valid?
      response = self.class.post(
        '/api/V2/Product/', 
        {
          :body => Hash[*self.create_keys.collect { |x| [x, self.send(x)] }.flatten].to_json
        }
      )      
      response
    end

    def sync
      variant = Spree::Variant.find_by_sku(self.Barcode)
      
      if variant
        category = Spree::Taxon.find_by_eposnow_category_id(self.CategoryID)
        product = variant.product
        
        unless category.nil?
          unless product.taxons.include?(category)
            product.taxons << category
            product.save
          end          
        end
        variant.cost_price = self.CostPrice
        variant.price = Money.new(self.SalePrice)
        variant.eposnow_product_id = self.ProductID
        variant.save
      else
        product = Spree::Product.new
        product.name = self.Name
        product.description = self.Description
        product.shipping_category = Spree::ShippingCategory.first
        if self.Sku.blank?
          product.sku = self.Sku
        else
          product.sku = self.Barcode
        end
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
      [:ProductID]+required_text_fields+unrequired_text_fields+boolean_fields
    end

    def create_keys
      (keys - [:ProductID])
    end

    def required_text_fields
      [:Name, :CostPrice, :SalePrice, :EatOutPrice]
    end

    def unrequired_text_fields
      [
        :Description,:CategoryID, :Barcode, :TaxRateID, :EatOutTaxRateID, :Sku,
        :BrandID, :SupplierID, :PopupNoteID,
        :UnitOfSale, :VolumeOfSale, :MultiChoiceID, :ColourID,
        :VariantGroupID, :Size, :OrderCode, :ButtonColourID
      ]
    end

    def boolean_fields
      [:SellOnWeb, :SellOnTill]
    end

    def index_fields
      [:Name, :CostPrice, :SalePrice]+[:ProductID, :Barcode, :Sku]+[:SellOnWeb]
    end

  end

end