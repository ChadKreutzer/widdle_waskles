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
    today = Date.today
    @photos = Photo.all
    @testimonial = Testimonial.order("RANDOM()").first
    @specials = Special.where("expires >= ?", today)
    @services = Service.all
    erb :index
  end
  
  # CMS Dashboard
  get '/jenna' do
    erb :jenna, :layout => :cms_layout
  end
  
  # Testimonials Database CRUD
  post '/jenna/testimonials/new' do
    @testimonial = Testimonial.create(story: params[:story], name: params[:name])
    redirect '/jenna/testimonials'
  end

  get '/jenna/testimonials' do
    @testimonials = Testimonial.all
    erb :'testimonials/index', :layout => :cms_layout
  end

  get "/jenna/testimonials/:id" do
    @testimonial = Testimonial.find(params[:id])
    erb :'testimonials/post_page', :layout => :cms_layout
  end

  put '/jenna/testimonials/:id' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.update(story: params[:story], name: params[:name])
    @testimonial.save
    redirect '/jenna/testimonials/' + params[:id]
  end

  delete '/jenna/testimonials/:id/delete' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    redirect '/jenna/testimonials'
  end

  # Specials Database CRUD
  post '/jenna/specials/new' do
    @special = Special.create(headline: params[:headline],
                              offer: params[:offer],
                              expires: params[:expires]
                              )
    redirect '/jenna/specials'
  end

  get '/jenna/specials' do
    @specials = Special.all
    erb :'specials/index', :layout => :cms_layout
  end

  get "/jenna/specials/:id" do
    @special = Special.find(params[:id])
    erb :'specials/post_page', :layout => :cms_layout
  end

  put '/jenna/specials/:id' do
    @special = Special.find(params[:id])
    @special.update(headline: params[:headline],
                    offer: params[:offer],
                    expires: params[:expires]
                    )
    @special.save
    redirect '/jenna/specials/' + params[:id]
  end

  delete '/jenna/specials/:id/delete' do
    @special = Special.find(params[:id])
    @special.destroy
    redirect '/jenna/specials'
  end
  
  # Services Database CRUD
  post '/jenna/services/new' do
    @service = Service.create(task: params[:task],
                              species: params[:species],
                              price: params[:price]
                              )
    redirect '/jenna/services'
  end

  get '/jenna/services' do
    @services = Service.all
    erb :'services/index', :layout => :cms_layout
  end

  get "/jenna/services/:id" do
    @service = Service.find(params[:id])
    erb :'services/post_page', :layout => :cms_layout
  end

  put '/jenna/services/:id' do
    @service = Service.find(params[:id])
    @service.update(task: params[:task],
                    species: params[:species],
                    price: params[:price]
                    )
    @service.save
    redirect '/jenna/services/' + params[:id]
  end

  delete '/jenna/services/:id/delete' do
    @service = Service.find(params[:id])
    @service.destroy
    redirect '/jenna/services'
  end

  # Photos Database CRUD
  post '/jenna/photos/new' do
    @photo = Photo.create(before_filename: params[:before_filename][:filename],
                          after_filename: params[:after_filename][:filename],
                          caption: params[:caption]
                          )
    file_action(:before_filename)
    file_action(:after_filename)

    redirect '/jenna/photos'
  end

  get '/jenna/photos' do
    @photos = Photo.all
    erb :'photos/index', :layout => :cms_layout
  end

  get "/jenna/photos/:id" do
    @photo = Photo.find(params[:id])
    erb :'photos/post_page', :layout => :cms_layout
  end

  put '/jenna/photos/:id' do
    @photo = Photo.find(params[:id])
    unless params[:before_filename].blank?
      file_action(@photo.before_filename)
      @photo.update(before_filename: params[:before_filename][:filename])
      file_action(:before_filename)
    end
    unless params[:after_filename].blank?
      file_action(@photo.after_filename)
      @photo.update(after_filename: params[:after_filename][:filename])
      file_action(:after_filename)
    end

    @photo.update(caption: params[:caption])
    @photo.save

    redirect '/jenna/photos/' + params[:id]
  end

  delete '/jenna/photos/:id/delete' do
    @photo = Photo.find(params[:id])
    file_action(@photo.before_filename)
    file_action(@photo.after_filename)
    @photo.destroy
    redirect '/jenna/photos'
  end

  def file_action(name)
    if name.is_a? Symbol
      @filename = params[name][:filename]
      file = params[name][:tempfile]
      File.open("./public/images/photos/#{@filename}", 'wb') do |f|
        f.write(file.read)
      end
    elsif name.is_a? String
      File.delete("./public/images/photos/#{name}")
    end
  end
end
