require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'mongo'
require 'mongoid'

Dir["models/*.rb"].each {|file| require_relative file }

configure do
  Mongoid.load!('mongoid.yml')
end