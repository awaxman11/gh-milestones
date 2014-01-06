# Require additional configuration file if it exists.
require './config/authentication' if File.exists?('./config/authentication.rb')

# Include Sinatra libraries.
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# ==> Include debug capabilities in development.
configure :development do
  require 'better_errors'
  require 'binding_of_caller'
  require 'pry-debugger'

  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)

  register Sinatra::Reloader
  also_reload 'lib/*/*.rb'
end

# Database setup.
configure :development do
 set :database, 'sqlite:///development.db'
 set :show_exceptions, true
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end

# Include all models (.rb files) in /lib/*/
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +'/*.rb').each do |file|
    require file
  end
end