module UsersHelper

def all_games(user)
  return GameUser.where(user: user) 
end

def played_games(user)
  gus = all_games(user)
  return Game.where(game_users: gus, state: "finished")
end

def playing_games(user)
  ongoing_games = Game.where(state: 'ongoing')
  return GameUser.where(user: user, game: ongoing_games )#state: 'player'
end

def win_games(user)
  return GameUser.where(user: user, state: ['whoop_winner', 'instant_winner'])
end

def whoop_games(user)
  return GameUser.where(user: user, state: 'whoop_winner')
end

def instant_games(user)
  return GameUser.where(user: user, state: 'instant_winner')
end

# def show_user_cards
#    @cards.each do|card|
#       chip_ids = card.chip_ids
#       chips_in_words = Array.new
#       chip_states = Array.new
#       chip_ids.each do|chip_id|
#         words, state = Chip.find(chip_id).translate
#         chips_in_words.push(words)
#         chip_states.push(state)
#       end
#       # flash[:notice] = "help"
#       render 'cards/_card', locals: { plays:chips_in_words, states:chip_states }
#     end
# end

def check_states_winner_rule
  $win_card_num=0

  @cards.each do|card|
    s = Array.new

    ccs = CardChip.where(:card => card)
    ccs.each do |cc|
      words, state = Chip.find(cc.chip_id).translate 
      s.push(state)
    end

     t1=s[0] && s[1] && s[2]
     t2=s[3] && s[4] && s[5]
     t3=s[6] && s[7] && s[8]
     t4=s[0] && s[3] && s[6]
     t5=s[1] && s[4] && s[7]
     t6=s[2] && s[5] && s[8]
     t7=s[0] && s[4] && s[8]
     t8=s[2] && s[4] && s[6]

     if (t1 || t2 || t3 || t4 || t5 || t6 || t7 || t8)
       $win_card_num=$win_card_num+1
     end
  end

  return $win_card_num
end

end
