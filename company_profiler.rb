require 'httparty'
require 'json'

class CompanyProfiler

  include HTTParty

  base_uri('api.glassdoor.com')

  API_KEY = ENV["GLASSDOOR_API_KEY"]
  USER_ID = ENV["GLASSDOOR_UID"]

  def initialize(company_name, user_ip)
    @options = { :query => { :v => '1', 
                             :format => "json", 
                             "t.p" => USER_ID, 
                             "t.k" => API_KEY, 
                             :userip => user_ip, 
                             :useragent => "chrome",
                             :action => "employers", 
                             :q => company_name}}
  end

  def company_profile
    response = self.class.get("/api/api.htm", @options)

    response["response"]["employers"][0]
  end
end