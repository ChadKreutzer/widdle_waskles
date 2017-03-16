source 'https://rubygems.org'

gem 'sinatra', require: 'sinatra/base'
gem 'rdiscount'
gem 'sprockets'
gem 'activerecord' # rake db:create_migration NAME=create_appropriate_name
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'rake'
gem 'uglifier'
gem 'sass'
gem 'bootstrap-sass'
gem 'puma'
gem 'pony'

group :development do
  gem 'tux'
  gem 'sqlite3'
  gem 'sinatra-contrib', require: 'sinatra/reloader'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
