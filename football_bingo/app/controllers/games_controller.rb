class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    visteam = Team.where(:nameid => @game.visteam).first
    hometeam = Team.where(:nameid => @game.hometeam).first
    @vis_totals = Total.where(:team => visteam, :game => @game).first
    @home_totals = Total.where(:team => hometeam, :game => @game).first

    render 'show'

  end

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

  def join
    gu_param = {
          :user_id => params[:user_id],
          :game_id => params[:game_id]
        }
    @gu = GamesUser.where(gu_param).first

    if @gu.nil?
        flash[:success] = "You play this game for the first time!"
        games_user = GamesUser.new(gu_param)
        games_user.save
        redirect_to user_game_play_path(params[:user_id], params[:game_id])
    else      
        flash[:warning] = "You can continue this game!"
        redirect_to user_game_play_path(params[:user_id], params[:game_id])
    end
  end

  def play_game
      render 'play'

  end
  
  # def stats
  #   # get the current game
  #   @games = Game.all

  #   if @games.nil?
  #     flash[:warning] = "No record."
  #   end

  #   @current_game = Game.where(:state => "upcoming").first # todo change to ongoing
  #   visteam = Team.where(:nameid => @current_game.visteam).first
  #   hometeam = Team.where(:nameid => @current_game.hometeam).first
  #   @vis_totals = Total.where(:team => visteam, :game => @current_game).first
  #   @home_totals = Total.where(:team => hometeam, :game => @current_game).first


  #   if @current_game.nil?
  #     render 'game_stats'
  #   else
  #     render 'game_stats'
  #   end
  # end

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
