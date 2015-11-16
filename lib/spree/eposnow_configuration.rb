module Spree
  class EposnowConfiguration < Preferences::Configuration
    preference :paypal_express_local_confirm, :boolean, :default => true
  end
end