require 'sinatra'
require_relative './scraper.rb'
require_relative './locator.rb'

enable :sessions

get '/' do
  locator = Locator.new(request.ip)
  session["location"] = locator.location
  erb :index
end

post '/' do
  query = params[:qurey]
  # location = params[:location]
  duration = params[:duration].to_i
  scraper = DiceScraper.new
  info = scraper.search_jobs(query, session["location"], duration)
  erb :result, :locals => {:info => info}
  # redirect to('/result')
end

# get '/result' do
#   erb :result, :local => {:info => @info}
# end