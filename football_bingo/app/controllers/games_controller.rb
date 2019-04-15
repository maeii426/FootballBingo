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

    @game=Game.find_by(whoop_winner: params[:whoop_winner])
    if @game.nil?
      redirect_to '/score_board', notice: 'No game information !'
    else
      @user=User.find_by(name: @game.whoop_winner)
      if @user.nil?
        redirect_to '/score_board', notice: 'No winner account information !'
      else
        WhoopMailer.send_email(@user).deliver_now
        redirect_to '/score_board', notice: 'Winners are notified !'
      end
    end
  end

end
