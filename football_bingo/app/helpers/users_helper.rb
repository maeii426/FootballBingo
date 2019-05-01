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

def check_states_winner_rule
  win_card_num=0
  size = 3 # the size of the card

  @cards.each do|card|
    s = Array.new

    ccs = CardChip.where(:card => card)
    ccs.each do |cc|
      words, state = Chip.find(cc.chip_id).translate 
      s.push(state)
    end

    all_conditions = []

    (0..size-1).each do |d|
      # all the winning conditions in rows
      win_in_row = true
      (size*d..size*(d+1)-1).each do |i|
        win_in_row &&= s[i]
      end
      all_conditions.push(win_in_row)

      # all the winning conditions in cols
      win_in_col = true
      col_ids_j = Array.new(size) { |s| s = size * s + d }
      col_ids_j.each do |j|
        win_in_col &&= s[j]
      end
      all_conditions.push(win_in_col)
    end

    # all the winning condition in diagonals
    win_in_diag0 = true
    diag_ids0 = Array.new(size) { |s| s = size * s + s}
    diag_ids0.each do |i|
      win_in_diag0 &&= s[i]
    end
    all_conditions.push(win_in_diag0)

    win_in_diag1 = true
    diag_ids1 = Array.new(size) { |s| s = size * (s+1) - 1 - s }
    diag_ids1.each do |i|
      win_in_diag1 &&= s[i]
    end
    all_conditions.push(win_in_diag1)

    # check all the conditions
    win_condition = false
    all_conditions.each do |cond|
      win_condition ||= cond
      puts cond
    end

    if win_condition
      win_card_num += 1
    end

     # t1=s[0] && s[1] && s[2]
     # t2=s[3] && s[4] && s[5]
     # t3=s[6] && s[7] && s[8]
     # t4=s[0] && s[3] && s[6]
     # t5=s[1] && s[4] && s[7]
     # t6=s[2] && s[5] && s[8]
     # t7=s[0] && s[4] && s[8]
     # t8=s[2] && s[4] && s[6]

     # if (t1 || t2 || t3 || t4 || t5 || t6 || t7 || t8)
     #   win_card_num=win_card_num+1
     # end
  end
  return win_card_num
end

end
