module GamesHelper

def game_helper_load
    # Fetch and parse HTML document
    doc = Nokogiri::XML(open(Rails.root + @game_path))    #('https://nokogiri.org/tutorials/installing_nokogiri.html'))

    # ASSUMPTIONS
        # no '_' tokens in the XML tag
        # right now - tags that should have only one instance are assumed to have only one instance
        # ********* CONDITION IS >
        
    # Game metadata
    
    # PER TEAM
    # Linescore
    # Totals
    # Player
    
    # Scores
    
    # fgas
    
    # drives
    
    # PER QTR
    # plays
    # drivestart
    # drivesum
    # score
    # qtr summary
    
    
    tokens = @conditional.split('_', 2)
    doc_content = doc.at(tokens[0])
    if doc_content
        entries = doc_content.to_s
        if entries.include?(tokens[1])
            doc_value = entries.match(/#{tokens[1]}="([^"]*)"/).captures
            #doc_value = entries.match(/(?<#{tokens[1]}>\w+)/)
            if value <= doc_value[0].to_f
                return true
            end
        end
    end
    false
end

def get_stats(tag_input, is_home)
    trans = Translation.where(:tag => tag_input).first
    if is_home
        return Totalcondition.where(:total => @home_totals, :translation =>trans).first.value
    else
        return Totalcondition.where(:total => @vis_totals, :translation =>trans).first.value
    end
end

def get_state(game)
    if game.is_finished?
        return "Finished" 
    elsif game.is_ongoing?
        return "Ongoing"
    else
        return "Upcoming"
    end
end

end
