module GamesHelper

def game_helper_load
    # Load data somewhere else

    # Fetch and parse HTML document
    #doc = Nokogiri::XML(open(Rails.root + @game_path))    #('https://nokogiri.org/tutorials/installing_nokogiri.html'))

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


    # tokens = @conditional.split('_', 2)
    # doc_content = doc.at(tokens[0])
    # if doc_content
    #     entries = doc_content.to_s
    #     if entries.include?(tokens[1])
    #         doc_value = entries.match(/#{tokens[1]}="([^"]*)"/).captures
    #         #doc_value = entries.match(/(?<#{tokens[1]}>\w+)/)
    #         if value <= doc_value[0].to_f
    #             return true
    #         end
    #     end
    # end
    # false
end

def get_stats(tag_input, is_home)
    trans = Translation.where(:tag => tag_input).first
    if is_home
        tc = Totalcondition.where(:total => @home_totals, :translation =>trans).first
        if !tc.nil?
            return tc.value
        else
            # return 0
        end
    else
        tc = Totalcondition.where(:total => @vis_totals, :translation =>trans).first
        if !tc.nil?
            return tc.value
        else
            # return 0
        end
    end
end

def get_state(game)
    if game.finished?
        return "Finished"
    elsif game.ongoing?
        return "Ongoing"
    else
        return "Upcoming"
    end
end

def played?(user, game)
  return GameUser.where(user: user, game: game).any?
end

def instant_winner(game)
    if !game.upcoming?
        gu = GameUser.where(:game => game, :state => "instant_winner").first
        if(!gu.nil?)
            return gu.user
        end
    end
end

def instant_winner?(game)
    if !game.upcoming?
        return GameUser.where(:game => game, :state => "instant_winner").any?
    end
    false
end

def whoop_winner?(game)
    if !game.upcoming?
        return GameUser.where(:game => game, :state => "whoop_winner").any?
    end
    false
end

def whoop_winner(game)
    if !game.upcoming?
        gu = GameUser.where(:game => game, :state => "whoop_winner").first
        if(!gu.nil?)
            return gu.user
        end
    end
end

def check_winner(game, user)
    if whoop_winner?(game) && user == whoop_winner(game)
        return "Whoop Winner!"
    elsif instant_winner?(game) && user == instant_winner(game)
        return "Instant Winner!"
    else
        if game.finished?
            return "Good Luck Next Time.."
        elsif game.ongoing?
            return "Try!"
        end
    end
end

def check_num_whoop_cards(game, user)
    if whoop_winner?(game) && user == whoop_winner(game)
        return GameUser.where(:game => game, :state => "whoop_winner").first.whoops
    else
        return 0
    end
end

def show_card(card)
    @card = card
    ccs = CardChip.where(:card => card)
    # print ccs.length
    @chips_in_words = Array.new
    @chip_probs = Array.new
    @chip_states = Array.new
    ccs.each do |cc|
      words, state = Chip.find(cc.chip_id).translate
      prob = Chip.find(cc.chip_id).prob
      @chips_in_words.push(words)
      @chip_states.push(state)
      @chip_probs.push(prob)
    end
end

end
