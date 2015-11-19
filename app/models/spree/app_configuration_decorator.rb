module Spree
  AppConfiguration.class_eval do
    preference :eposnow_key, :string, default: nil
    preference :eposnow_secret, :string, default: nil
  end
end
