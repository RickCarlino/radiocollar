### A Ping is a stored location within the radio collar app.
class Ping

  include Mongoid::Document

  field :name
  field :lat
  field :lng
end