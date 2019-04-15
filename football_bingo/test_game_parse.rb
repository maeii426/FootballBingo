require 'nokogiri'

doc = Nokogiri::XML(open('./XML/tam.xml'))
doc.css('fbgame').each do |node|
  children = node.children

  # game = {
  #   "source" => node['source'], 
  #   "venue" => children.css('venue').inner_text, 
  #   "team" => children.css('team').inner_text, 
  # }

  children.css('team').each do |t|
        team_param = {
            :name => t['name'],
            :nameid => t['id']
          }

        puts team_param
      end

  puts game
end