# Add rake tasks here.
# They can also be added in the ./tasks folder.

require "sinatra/activerecord/rake"
require "./app"

Dir.glob("./tasks/*.rb").each do |file|
  require file
end