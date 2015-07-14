require 'httparty'
require 'json'

class Locator

  include HTTParty

  base_uri('www.telize.com')

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def location
    response = self.class.get("/geoip/#{ip_address}")
    city = response["city"] || ""
    region_code = response["region_code"] || ""
    country_code = response["country_code"] || ""
    [city, region_code, country_code].join(", ")
  end

  private

  def ip_address
    @ip_address
  end
end