# Include all models (.rb files) in /lib/*/

Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end