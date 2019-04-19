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

  def stats
    # get the current game
    @games = Game.all

    if @games.nil?
      flash[:warning] = "No record."
    end

    @current_game = Game.where(:state => "upcoming").first # todo change to ongoing
    visteam = Team.where(:nameid => @current_game.visteam).first
    hometeam = Team.where(:nameid => @current_game.hometeam).first
    @vis_totals = Total.where(:team => visteam, :game => @current_game).first
    @home_totals = Total.where(:team => hometeam, :game => @current_game).first


    if @current_game.nil?
      render 'game_stats'
    else
      render 'game_stats'
    end
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
