# Require all Ruby gems located in Gemfile.
require 'bundler'
Bundler.require

# Include Sinatra libraries.
require 'sinatra/base'
require 'sinatra/reloader'

# Include all models in lib/*/ folders.
require_relative 'environment'

# Rename 'AppName' to name of choice.
# => Don't forget to update config.ru as well.
module AppName
  class App < Sinatra::Application

    # Configure Options
    # => set configuration options for application.

    # ==> Set default paths of application.
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    # Include debug capabilities in development.
    configure :development do
      require 'better_errors'
      require 'binding_of_caller'
      require 'pry-debugger'

      use BetterErrors::Middleware
      BetterErrors.application_root = File.expand_path('..', __FILE__)

      register Sinatra::Reloader
      also_reload 'lib/*/*.rb'
    end

    # Database
    # => delete if not needed.
    set :database, "sqlite3:///database.db"

    # Filters
    # => add route filters if necessary.

    # Routes
    # => define controller actions for application.
    get '/' do
      erb :index
    end

    # Helpers
    # => define helper methods for application.
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end
  end
end