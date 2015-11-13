Spree::Core::Engine.routes.draw do

  namespace :admin do
    get :eposnow, to: 'eposnow#index'
  end

end
