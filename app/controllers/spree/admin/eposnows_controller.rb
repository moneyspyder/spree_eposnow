class Spree::Admin::EposnowsController < Spree::Admin::BaseController

  def edit
  end

  # https://api.eposnowhq.com/api/V2/Product/{Product_ID}
  def product
    @product = Spree::EposNow.product(prams[:id])    
  end

  def update
    params.each do |name, value|
      next unless Spree::Config.has_preference? name
      Spree::Config[name] = value
    end

    #flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:mail_method_settings))    
    flash[:success] = Spree.t(:successfully_updated, resource: 'Epos Now Settings')    
    redirect_to edit_admin_eposnow_url
  end

  # http://developer.eposnowhq.com/Docs/Product
  # GET https://api.eposnowhq.com/api/V2/Product?page={Page_No}

  def products
    @products = Spree::EposNow.products
  end

end
