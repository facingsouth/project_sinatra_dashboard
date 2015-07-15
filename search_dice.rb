require 'sinatra'
require "sinatra/reloader" if development?
require_relative './scraper.rb'
require_relative './locator.rb'
require_relative './company_profiler.rb'

enable :sessions

get '/' do
  locator = Locator.new("67.160.204.113") #(request.ip)
  session["ip"] = "67.160.204.113" #request.ip
  session["location"] = locator.location
  erb :index
end

post '/' do
  query = params[:query]
  location = params[:location]
  duration = params[:duration].to_i
  scraper = DiceScraper.new
  info = scraper.search_jobs(query, location, duration)
  erb :result, :locals => {:info => info, 
                           :query => query.upcase, 
                           :location => session["location"]}
end

get '/:company_name' do
  company_name = params[:company_name]
  cprofiler = CompanyProfiler.new(company_name, session["ip"])
  profile = cprofiler.company_profile
  erb :company, :locals => {:profile => profile, :name => company_name}
end
