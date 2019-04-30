# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!




listener = Listen.to('\\165.91.33.68\stat-share\\ftb', only: /tam.xml/) do |modified, added, removed|
  puts "modified absolute path: #{modified}"
  puts "added absolute path: #{added}"
  puts "removed absolute path: #{removed}"
end
listener.start # not blocking


listener_local = Listen.to('XML', only: /tam.xml/) do |modified, added, removed|
  puts "modified absolute path: #{modified}"
  puts "added absolute path: #{added}"
  puts "removed absolute path: #{removed}"
end
listener_local.start # not blocking




# initializer "watch_game_file" do |app|
#   # Watch for changes to javascript files:
#   app.reloaders << ActiveSupport::FileUpdateChecker.new(["XML/tam.xml"])

#   config.to_prepare do
#     game_helper_parse
#   end
# end