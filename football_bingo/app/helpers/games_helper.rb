module GamesHelper

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
            return "Keep going!"
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