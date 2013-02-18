require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'mongo'
require 'mongoid'

configure do
  Mongoid.load!('mongoid.yml')
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
#TODO: clear form on submit
#TODO: Make a live URL creator that shows user's URL as they type. (fake AJAX)
#TODO: Add form validation for new pings
#TODO: Add error messages for ping retrieval
#todo: tie into URL shortener API?


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
  ping = Ping.create(params)
end
