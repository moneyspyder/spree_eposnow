module Spree
  module Admin
    module Eposnow
      class CategoriesController < Spree::Admin::BaseController

        MAPPING = {
          "Name" => :name,
          "Description" => :description
        }

        def index
          @categories = Spree::Eposnow::Category.all
          # @categories =  Spree::EposNow.customers.collect do |x| 
          #                 x.slice("Forename", "Surname", "EmailAddress", "ContactNumber")
          #               end          
        end

        def sync
          root_category = Spree::Taxonomy.where(name: 'Categories').first_or_create
          root_taxon_category = Spree::Taxon.where(name: 'Categories')
          Spree::Eposnow::Category.all.each do |category|
            taxon = Spree::Taxon.where(name: category['Name']).first_or_initialize
            attributes = Hash[*MAPPING.collect { |key,value| [value, category[key]] }.flatten]
            attributes[:taxonomy] = root_category
            taxon.update_attributes(attributes)
          end
          flash[:success] = "Categories sync complete"
          return redirect_to admin_eposnow_categories_path
        end

      end

    end

  end

end

# * Kitchen Bed & Bath  
# * Gifts Jewellery & Stationery
# * Delivery
# * Home Accessories
# * Lighting
# * Furniture

# {"CategoryID"=>72656,
#  "Name"=>"Food",
#  "Description"=>"FoodCat",
#  "ParentID"=>nil,
#  "ShowOnTill"=>true,
#  "Wet"=>false,
#  "ButtonColourID"=>nil,
#  "SortPosition"=>nil,
#  "ReportingCategoryID"=>nil,
#  "NominalCode"=>nil}