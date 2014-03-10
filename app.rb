require_relative 'app_config'

### Base application class for sinatra.
class RadioCollar < Sinatra::Base
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
