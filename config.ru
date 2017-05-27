require 'bundler'
Bundler.setup :default
Bundler.require

require './app'

use Rack::MethodOverride

map '/assets/' do
  environment = Sprockets::Environment.new
  environment.js_compressor  = :uglify
  environment.css_compressor = :scss
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  run environment
end

run Rack::URLMap.new({
  "/" => Public,
  "/jenna" => Protected
})