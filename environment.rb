# Require Authentication / Configuration File
require './config/authentication' if File.exists?('./config/authentication.rb')

# Include Sinatra Libraries
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'sinatra/activerecord'

# Include Debug Capabilities in Development
configure :development do
  require 'better_errors'
  require 'binding_of_caller'
  require 'pry-debugger'

  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)

  register Sinatra::Reloader
  also_reload 'lib/*/*.rb'
end


# Include all models, concerns, and helpers in /lib/*/*.rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +'/*.rb').each do |file|
    require file
  end
end