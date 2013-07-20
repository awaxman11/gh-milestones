# Include all models in lib/*/ folders.
require_relative 'environment'

# Pre-compile Gemfile before running application.
require 'bundler'
Bundler.require

module Name
  class App < Sinatra::Application

    # Configure Options
    # => set folders of application.

    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
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
