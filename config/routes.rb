Spree::Core::Engine.routes.draw do

  namespace :admin do
    #get :eposnow, to: 'eposnow#index'
    #scope module: :eposnow do
    #  resources 'Eposnow::Customer'
    #resources [:eposnow, :customers]
    #end
    namespace :eposnow do
    #scope module: :eposnow do #, as: 'admin_eposnow' do
      resources :categories, only: [:index] do
        collection do
          post :sync
        end
      end
      resources :customers, except: [:destroy]
      resources :product_stocks, except: [:destroy] do
        collection do
          post :sync_all
        end
      end
      resources :locations, except: [:destroy] do
        member do 
          post :link
        end
      end
      resources :products, only: [:index, :show, :new, :create] do
        member do
          patch :sync
        end
        collection do
          post :sync_all
        end
      end
    end

    resource :eposnow, only: [:update, :edit] do
      get 'products/:id', to: 'eposnows#product', as: :product
      collection do
        #get :products
        get :transactions
        get :staff
      end
    end
  end

end
