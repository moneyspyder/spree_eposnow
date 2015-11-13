class Spree::EposNow

  def initialize(key,secret)
    @key, @secret = key, secret
  end

  def token
    Base64.encode64(@key+':'+@secret)
  end
  
end
