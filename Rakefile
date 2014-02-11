require 'sinatra/activerecord/rake'
require './app'

# Include all rake tasks located in lib/tasks folder.
Dir.glob('lib/tasks/*.rake').each { |r| load r }


# For TravisCI compatibility.
begin
  require 'rspec/core/rake_task'

  # Set default Rake task to run RSpec tests.
	RSpec::Core::RakeTask.new(:spec)
	task :default => :spec

# For Heroku compatibility.
rescue LoadError
end