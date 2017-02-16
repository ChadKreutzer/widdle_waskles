require 'bundler'
Bundler.require
Dir["./models/*"].each {|file| require file }

class MyApp < Sinatra::Base
  # initialize new sprockets environment
  set :environment, Sprockets::Environment.new

  # append assets paths
  environment.append_path "assets/stylesheets"
  environment.append_path "assets/javascripts"

  # compress assets
  environment.js_compressor  = :uglify
  environment.css_compressor = :scss
  
  # get assets
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end

  get '/' do
    @testemonials = Testemonial.all
    @photos = Photo.all
    @services = Service.all
    erb :index
  end
  
end