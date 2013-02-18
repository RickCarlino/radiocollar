require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'mongo'
require 'mongoid'

Mongoid.configure do |config|
  name = "mongoid_test_db"
  host = "localhost"
  port = 27017
  binding.pry
  config.database = Mongo::Connection.new.db(name)
end

class Ping
include Mongoid::Document
field :name
field :lat
field :lng
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
  ping = Ping.where(name: params[:name]).first
  redirect("https://maps.google.com/maps?q=#{ping.lat},#{ping.lng}")
end
post '/' do
  binding.pry
  ping = Ping.create(params)
end
