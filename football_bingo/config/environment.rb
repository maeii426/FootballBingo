# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

begin
    listener_grabber = Listen.to('../../stat-share\\ftb', only: /tam.xml/) do |modified, added, removed|
    #listener_grabber = Listen.to('', only: /tamtest.xml/) do |modified, added, removed|
      if !modified.nil? && !modified.empty?
          begin
            require 'nokogiri'
            filename = modified.first
          	doc = Nokogiri::XML(open(filename))
            sections = doc.css('fbgame').first.children
          	date = Date.strptime(sections.css('venue').first['date'], '%m/%d/%Y').strftime('%Y_%m_%d')
          	game = sections.css('venue').first['gameid']
          	name = (game + "_" + date + ".xml")
            dest = "XML/#{name}"
            FileUtils.cp_r(filename, dest, remove_destination: true)
            puts "[" + Time.now.getutc.to_s + "] LISTENER  update " + name
          rescue StandardError => err
            puts "Missed an update?  " + err.to_s
          end
      end
      
      if !added.nil? && !added.empty?
        begin
            require 'nokogiri'
            filename = added.first
          	doc = Nokogiri::XML(open(filename))
            sections = doc.css('fbgame').first.children
          	date = Date.strptime(sections.css('venue').first['date'], '%m/%d/%Y').strftime('%Y_%m_%d')
          	game = sections.css('venue').first['gameid']
          	name = (game + "_" + date + ".xml")
            dest = "XML/#{name}"
            FileUtils.cp_r(filename, dest, remove_destination: true)
            puts "[" + Time.now.getutc.to_s + "] LISTENER  update " + name
          rescue StandardError => err
            puts "Missed an update?  " + err.to_s
          end
      end
    end
    listener_grabber.start # not blocking
rescue StandardError => err
    puts ("------- XML game listener broken -- " + err.to_s + " -------")
end


listener_local = Listen.to('XML') do |modified, added, removed|
    include ImportXML
    if !modified.nil? && !modified.empty?
        modified.each do |filename|
            get_xml_game(filename)
        end
    end
    
    if !added.nil? && !added.empty?
        added.each do |filename|
            get_xml_game(filename)
        end
    end
end
listener_local.start # not blocking