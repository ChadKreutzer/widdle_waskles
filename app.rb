require 'sinatra/base'

class Public < Sinatra::Base
  get '/' do
    today = Date.today
    @photos = Photo.all
    @testimonial = Testimonial.order("RANDOM()").first
    @specials = Special.where("expires >= ?", today)
    @services = Service.all
    erb :index
  end
  
  post '/' do
  
    name  = params[:name]
    mail = params[:mail]
    subject = params[:subject]
    body  = params[:body]
      
    Pony.mail({ to:'chadkreutzer@outlook.com',
                subject: "#{subject}",
                body: "#{name}\n#{mail}\n\n#{body}",
                via: :smtp,
                via_options: {
                  address:              'smtp.sendgrid.net',
                  port:                 '587',
                  enable_starttls_auto: true,
                  user_name:            ENV['SENDGRID_USERNAME'],
                  password:             ENV['SENDGRID_PASSWORD'],
                  authentication:       :plain,
                  domain:               "localhost.localdomain" 
                }
              })
    
    redirect '/'
  end
end

class Protected < Sinatra::Base  
  # CMS Dashboard
  get '/' do
    erb :jenna, :layout => :cms_layout
  end
  
  # Testimonials Database CRUD
  post '/testimonials/new' do
    @testimonial = Testimonial.create(story: params[:story], name: params[:name])
    redirect '/jenna/testimonials'
  end

  get '/testimonials' do
    @testimonials = Testimonial.all
    erb :'testimonials/index', :layout => :cms_layout
  end

  get "/testimonials/:id" do
    @testimonial = Testimonial.find(params[:id])
    erb :'testimonials/post_page', :layout => :cms_layout
  end

  put '/testimonials/:id' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.update(story: params[:story], name: params[:name])
    @testimonial.save
    redirect '/jenna/testimonials/' + params[:id]
  end

  delete '/testimonials/:id/delete' do
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    redirect '/jenna/testimonials'
  end

  # Specials Database CRUD
  post '/specials/new' do
    @special = Special.create(headline: params[:headline],
                              offer: params[:offer],
                              expires: params[:expires]
                              )
    redirect '/jenna/specials'
  end

  get '/specials' do
    @specials = Special.all
    erb :'specials/index', :layout => :cms_layout
  end

  get "/specials/:id" do
    @special = Special.find(params[:id])
    erb :'specials/post_page', :layout => :cms_layout
  end

  put '/specials/:id' do
    @special = Special.find(params[:id])
    @special.update(headline: params[:headline],
                    offer: params[:offer],
                    expires: params[:expires]
                    )
    @special.save
    redirect '/jenna/specials/' + params[:id]
  end

  delete '/specials/:id/delete' do
    @special = Special.find(params[:id])
    @special.destroy
    redirect '/jenna/specials'
  end
  
  # Services Database CRUD
  post '/services/new' do
    @service = Service.create(task: params[:task],
                              species: params[:species],
                              price: params[:price]
                              )
    redirect '/jenna/services'
  end

  get '/services' do
    @services = Service.all
    erb :'services/index', :layout => :cms_layout
  end

  get "/services/:id" do
    @service = Service.find(params[:id])
    erb :'services/post_page', :layout => :cms_layout
  end

  put '/services/:id' do
    @service = Service.find(params[:id])
    @service.update(task: params[:task],
                    species: params[:species],
                    price: params[:price]
                    )
    @service.save
    redirect 'jenna/services/' + params[:id]
  end

  delete '/services/:id/delete' do
    @service = Service.find(params[:id])
    @service.destroy
    redirect 'jenna/services'
  end

  # Photos Database CRUD
  post '/photos/new' do
    @photo = Photo.create(before_filename: params[:before_filename][:filename],
                          after_filename: params[:after_filename][:filename],
                          caption: params[:caption]
                          )
    file_action(:before_filename)
    file_action(:after_filename)

    redirect '/jenna/photos'
  end

  get '/photos' do
    @photos = Photo.all
    erb :'photos/index', :layout => :cms_layout
  end

  get "/photos/:id" do
    @photo = Photo.find(params[:id])
    erb :'photos/post_page', :layout => :cms_layout
  end

  put '/photos/:id' do
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

  delete '/photos/:id/delete' do
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
  
  def self.new(*)
    app = Rack::Auth::Digest::MD5.new(super) do |username|
      { "user" => "password" }[username]
    end
    app.realm = 'Protected Area'
    app.opaque = 'secretkey'
    app
  end
end
