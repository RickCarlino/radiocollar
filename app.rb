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

#Turn this on if you end up using this backend for a phonegap API or something like that.
#set :allow_origin, :any
# set :allow_methods, [:get, :post, :options]

#TODO: Make a live URL creator that shows user's URL as they type.
#TODO: Add form validation for new pings (client side and server side)
#todo: tie into URL shortener API?
#todo: favicon.ico
#todo: make pretty error pages
#TODO: Prevent default when user pressed enter on retrieval form.



get '/:file' do
  File.open("public/#{params[:file]}").readlines
end

get '/' do
  File.open("public/index.html").readlines
end

get '/p/:name' do
  ping = Ping.where(name: params[:name]).first
  if ping.nil?
    "That location was not found. Double check the name."
  else
    redirect("https://maps.google.com/maps?q=#{ping.lat},#{ping.lng}")
  end
end

post '/' do
  unless Ping.create(params)
    "Something went wrong"
  end
end
