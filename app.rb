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
    @testimonial = Testimonial.order("RANDOM()").first
    erb :index
  end
  
  # Testimonials Database CRUD
  post '/testimonials/new' do
    @testimonial = Testimonial.create(story: params[:story], name: params[:name])
    redirect '/testimonials'
  end
  
  get '/testimonials' do
    @testimonials = Testimonial.all
    erb :'testimonials/index', :layout => false
  end
  
  get "/testimonials/:id" do
    @testimonial = Testimonial.find(params[:id])
    erb :'testimonials/post_page', :layout => false
  end
  
  put '/testimonials/:id' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.update(story: params[:story], name: params[:name])
    @testimonial.save
    redirect '/testimonials/' + params[:id]
  end
  
  delete '/testimonials/:id/delete' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    redirect '/testimonials'
  end
  
end