module Bitstamp
  extend self

  def latest
    response = HTTParty.get("https://www.bitstamp.net/api/ticker/")
    response["last"].to_f
  end
end
