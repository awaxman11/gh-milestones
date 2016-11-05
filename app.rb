# Include:
# => Authentication File
# => Concerns | Helpers | Models
# => Database Configuration
# => Debug Tools
# => Sinatra Libraries

require 'sinatra'
require 'sinatra/activerecord'
require 'cgi'

require 'json'
require 'mechanize'

require_relative 'environment'

require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './lib/sinatra/auth/github.rb'
require './lib/concerns/milestone.rb'
require './lib/concerns/overview.rb'
require './lib/concerns/category.rb'

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
      erb :index, :locals => { main_nav: false, back_button: false }
    end

    get '/login' do
      redirect "https://github.com/login/oauth/authorize?client_id="+ENV['GITHUB_CLIENT_ID']+"&redirect_url=/&scope=repo"
    end

    get '/overview_stats.json' do
      if authenticated?
        content_type :json
        client = github_user.api
        client.auto_paginate = true
        Overview.get_links(client).to_json
      else 
        redirect '/'
      end
    end

    get '/overview' do
      if authenticated?
        erb :overview, :locals => {main_nav: false, back_button: false}
      else 
        redirect '/'
      end
    end

    get '/milestones' do
      if authenticated?
        client = github_user.api
        client.auto_paginate = true
        milestones = client.list_milestones("seatgeek/tixcast")
        milestones.sort! { |a,b| a[:title].downcase <=> b[:title].downcase }
        erb :milestones, :locals => { milestones: milestones, main_nav: true, back_button: false}
      else
        redirect '/'
      end
    end

    get '/milestones/:id' do
      if authenticated?
        client = github_user.api
        puts client
        m = Milestone.new("seatgeek/tixcast", params[:id], client)
        @issues = m.issues
        @milestone = m.milestone
        @stats = m.stats
        @is_no_priority = m.is_no_priority?
        erb :show, :locals => { issues: @issues, stats: @stats, milestone: @milestone, main_nav: true, back_button: true, is_no_priority: @is_no_priority  }
      else
        redirect '/'
      end
    end

    get '/categories.json' do
      if authenticated?
        content_type :json
        client = github_user.api
        client.auto_paginate = true
        c = Category.new("seatgeek/tixcast", client)
        categories = c.categories
        categories.to_json
      else 
        redirect '/'
      end
    end

    get '/categories' do 
      if authenticated?
        erb :categories, :locals => {main_nav: false, back_button: false}
      else 
        redirect '/'
      end
    end

    get '/logout' do
      logout!
      redirect '/'
    end

    # Routes related to new triaging pages

    get '/triage' do
      erb :triage, :locals => { main_nav: false, back_button: false }
    end

    get '/triage/all-issues' do
      if authenticated?
        erb :triage_all_issues, :locals => {main_nav: false, back_button: false}
      else 
        redirect '/'
      end
    end

    get '/triage_stats_all_issues.json' do
      if authenticated?
        content_type :json
        client = github_user.api
        client.auto_paginate = true
        Overview.get_triage_stats_all_issues_links(client).to_json
      else 
        redirect '/'
      end
    end

    get '/triage/stale-issues' do
      if authenticated?
        erb :triage_stale_issues, :locals => {main_nav: false, back_button: false}
      else 
        redirect '/'
      end
    end

    get '/triage_stats_stale_issues.json' do
      if authenticated?
        content_type :json
        client = github_user.api
        client.auto_paginate = true
        Overview.get_triage_stats_stale_issues_links(client).to_json
      else 
        redirect '/'
      end
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
