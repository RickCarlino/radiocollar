require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'


Mongoid.configure do |config|
  if ENV['MONGOHQ_URL']
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    uri = URI.parse(ENV['MONGOHQ_URL'])
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('test')
  end
end

class Ping
  include Mongoid::Document
  field :waypoint
  field :lat, type: float
  field :lng, type: float
end

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]

#TODO: Make hint text disappear on waypoint name textbox onClick

get '/:file' do
  File.open("public/#{params[:file]}").readlines
end

get '/' do
  File.open("public/index.html").readlines
end

get '/p/:name' do
  ping = Ping.where(name: params[:name])
  redirect("https://maps.google.com/maps?q=#{ping.lat},#{ping.lng}")
end
post '/' do
  ping = Ping.create(params)
  puts "\n\n\n============================="
  puts Ping.last.inspect
  puts "\n\n\n============================="
end
