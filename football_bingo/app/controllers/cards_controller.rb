class CardsController < ApplicationController
    
    # Generate cards
    # remove ftns later 
    def index 
        render 'cards/card.html.erb'
        #redirect_to root_path
        #head :ok
    end

    # remove later 
    def temp_card  
        #from this function we will send the play to the specific cards
        #this is still hardcoded
        @card = Card.where(cardid: '1').first
        play1 = @card.b11
        play2 = @card.b21
        play3 = @card.b31
        play4 = @card.b12
        play5 = @card.b22
        play6 = @card.b32
        play7 = @card.b13
        play8 = @card.b23
        play9 = @card.b33
        render 'cards/_card', locals: { play1:Chip.where(chipid: play1).first.translate, play2:Chip.where(chipid: play2).first.translate,play3:Chip.where(chipid: play3).first.translate,
                            play4:Chip.where(chipid: play4).first.translate,play5:Chip.where(chipid: play5).first.translate,play6:Chip.where(chipid: play6).first.translate,
                            play7:Chip.where(chipid: play7).first.translate,play8:Chip.where(chipid: play8).first.translate,play9:Chip.where(chipid: play9).first.translate }
    end
    
end
