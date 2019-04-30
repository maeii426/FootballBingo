  namespace :import do
	desc 'import game from XML'
	task :getxmlgame => :environment do
		include ImportXML
		get_xml_game("./XML/tam.xml")
	end
end
