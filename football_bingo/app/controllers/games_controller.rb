class GamesController < ApplicationController

  def game_params
    params.require(:game).permit(:game_name, :date, :instant_winner, :whoop_winner)
  end

  def score_board
    @games = Game.all
    if @games.nil?
      flash[:warning] = "No record."
    end
    return @games
  end

  def send_email
    @games = Game.all
    redirect_to '/score_board', notice: 'Winners are notified !'
  end


end
