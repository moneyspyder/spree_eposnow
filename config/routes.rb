Spree::Core::Engine.routes.draw do

  namespace :admin do
    #get :eposnow, to: 'eposnow#index'
    resources :eposnow, only: [:index] do
      member do
        get :product
      end
      collection do
        get :products
      end
    end
  end

end
