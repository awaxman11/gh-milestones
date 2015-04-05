# Include:
# => Authentication File
# => Concerns | Helpers | Models
# => Database Configuration
# => Debug Tools
# => Sinatra Libraries

require 'sinatra'
require 'sinatra/activerecord'

require_relative 'environment'

require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './lib/sinatra/auth/github.rb'
require './lib/concerns/milestone.rb'

# Rename 'AppName' to name of choice.
# => Update 'AppName' : config.ru // spec_helper.rb
module AppName
  class App < Sinatra::Application
    register Sinatra::ActiveRecordExtension
    enable :sessions

    # Configure Options
    # ==> Set default paths for static content.
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    set :github_options, {
      :scopes    => "repo",
      :secret    => ENV['GITHUB_CLIENT_SECRET'],
      :client_id => ENV['GITHUB_CLIENT_ID'],
    }

    register Sinatra::Auth::Github

    # ==> Set global JavaScript files for pfroject.
    set :javascripts, [:jquery]

    # Filters
    # => add route filters.

    # Routes
    # => define controller actions.

    # ==> Render index page.

    get '/' do
      erb :index
    end

    get '/login' do
      redirect "https://github.com/login/oauth/authorize?client_id="+ENV['GITHUB_CLIENT_ID']+"&redirect_url=/&scope=repo"
    end

    get '/milestones' do
      if authenticated?
        client = github_user.api
        client.auto_paginate = true
        @milestones = client.list_milestones("seatgeek/tixcast")
        @milestones.sort! { |a,b| a[:title].downcase <=> b[:title].downcase }
        erb :milestones, :locals => { :milestones => @milestones}
      else
        redirect '/'
      end
    end

    get '/milestones/:id' do
      if authenticated?
        puts "hello"
        client = github_user.api
        puts client
        m = Milestone.new("seatgeek/tixcast", params[:id], client)
        puts m.get_stats
        @issues = m.issues
        @pretty_stats = m.get_stats
        erb :show, :locals => { issues: @issues, stats: @pretty_stats }
      else
        redirect '/'
      end
    end

    get '/logout' do
      logout!
      redirect '/'
    end

    # Helpers
    # => define helper methods.

    helpers do
      include Rack::Utils

      # ==> Capability to escape HTML.
      alias_method :h, :escape_html

      # ==> Enable partials in all templates.
      def partial(file_name)
        erb file_name, :layout => false
      end
    end
  end
end
