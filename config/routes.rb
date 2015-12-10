Spree::Core::Engine.routes.draw do

  namespace :admin do
    #get :eposnow, to: 'eposnow#index'
    resource :eposnow, only: [:update, :edit] do
      get 'products/:id', to: 'eposnows#product', as: :product
      collection do
        get :products
        get :customers
        get :stock_controls
        get :transactions
        get :staff
      end
    end
  end

end
