module UsersHelper

def show_user_cards
   @cards.each do|card|
      chip_ids = card.chip_ids 
      chips_in_words = Array.new
      chip_states = Array.new
      chip_ids.each do|chip_id|
        words, state = Chip.find(chip_id).translate
        chips_in_words.push(words)
        chip_states.push(state)
      end
      flash[:notice] = "help"
      render 'cards/_card', locals: { plays:chips_in_words, states:chip_states }
    end 
end
    
end
