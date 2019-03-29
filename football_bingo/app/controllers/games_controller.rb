class GamesController < ApplicationController

  def game_params
    params.require(:game).permit(:gameid, :date, :instant_winner, :whoop_winner)
  end

  def score_board
    @games = Game.all
    if @games.nil?
      flash[:warning] = "No record."
    end
    return @games
  end

  def game_play  #from this function we will send the play to the specific cards
    play1 = 'This is Play 1'
    play2 = 'Play 2'
    play3 = 'Play 3'
    play4 = 'predicted plays from game controller'
    play5 = 'Play 5'
    play6 = 'Play 6'
    play7 = 'Play 7'
    play8 = 'Play 8'
    play9 = 'Play 9'
    render 'games/game_play', locals: { play1: play1, play2:play2,play3:play3,
                                        play4:play4,play5:play5,play6:play6,
                                        play7:play7,play8:play8,play9:play9 }
  end

end
