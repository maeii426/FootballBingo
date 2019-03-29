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

 

end
