module Spree
  AppConfiguration.class_eval do
    # Default mail headers settings
    preference :eposnow_key, :string, default: nil
    preference :eposnow_secret, :string, default: nil
  end
end
