Spree::Core::Engine.routes.draw do

  namespace :admin do
    #get :eposnow, to: 'eposnow#index'
    #scope module: :eposnow do
    #  resources 'Eposnow::Customer'
    #resources [:eposnow, :customers]
    #end
    namespace :eposnow do
    #scope module: :eposnow do #, as: 'admin_eposnow' do
      resources :customers, except: [:destroy]
      resources :product_stocks, except: [:destroy]
    end

    resource :eposnow, only: [:update, :edit] do
      get 'products/:id', to: 'eposnows#product', as: :product
      collection do
        get :products
        get :transactions
        get :staff
      end
    end
  end

end
