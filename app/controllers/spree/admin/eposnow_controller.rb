class Spree::Admin::EposnowController < Spree::Admin::BaseController

  def index
  end

  # https://api.eposnowhq.com/api/V2/Product/{Product_ID}
  def product
    @product = {
      'ProductID' => 6,
      'Name' => "Tea",
      'Description' => nil,
      'CostPrice' => 0.3,
      'SalePrice' => 1.5,
      'EatOutPrice' => 0,
      'CategoryID' => nil,
      'Barcode' => nil,
      'TaxRateID' => 33
    }
  end

  # http://developer.eposnowhq.com/Docs/Product
  # GET https://api.eposnowhq.com/api/V2/Product?page={Page_No}
  def products
    @products = [
      {
        'ProductID' => 6,
        'Name' => "Tea",
        'Description' => nil,
        'CostPrice' => 0.3,
        'SalePrice' => 1.5       
      },
      {
        'ProductID' => 7,
        'Name' => "Coffee",
        'Description' => nil,
        'CostPrice' => 0.3,
        'SalePrice' => 1.6       
      }             
      # {
      #   ProductID: 6,
      #   Name: "Tea",
      #   Description: nil,
      #   CostPrice: 0.3,
      #   SalePrice: 1.5,
      #   EatOutPrice: 0,
      #   CategoryID: nil,
      #   Barcode: nil,
      #   TaxRateID: 33,
      #   EatOutTaxRateID: nil,
      #   BrandID: nil,
      #   SupplierID: nil,
      #   PopupNoteID: nil,
      #   UnitOfSale: nil,
      #   VolumeOfSale: nil,
      #   MultiChoiceID: nil,
      #   ColourID: nil,
      #   VariantGroupID: nil,
      #   Size: nil,
      #   Sku: nil,
      #   SellOnWeb: false,
      #   SellOnTill: true,
      #   OrderCode: nil,
      #   ButtonColourID: nil,
      #   SortPosition: nil,
      #   MagentoAttributeSetID: nil,
      #   RRPrice: nil,
      #   CostPriceTaxRateID: nil,
      #   ProductType: 0,
      #   TareWeight: nil,
      #   ArticleCode: nil        
      # }
    ]
  end

end
