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

  def score_board
    @games = Game.all

    # if @games.nil?
    #   flash[:warning] = "No record."
    #   redirect_to games_path
    # end

    return @games
  end

  # POST /users/1/games/1/join
  def join
    gu_param = {
          :user_id => params[:user_id],
          :game_id => params[:game_id]
        }
    @gu = GameUser.where(gu_param).first
    if @gu.nil?
        flash[:success] = "You play this game for the first time!"
        games_user = GameUser.new(gu_param)
        games_user.save
        redirect_to user_game_play_path(params[:user_id], params[:game_id])
    else      
        flash[:warning] = "You can continue this game!"
        redirect_to user_game_play_path(params[:user_id], params[:game_id])
    end
  end

  # GET /users/1/games/1/play
  def play_game     
      @cards = Card.where(:user_id => params[:user_id], :game_id => params[:game_id])
      @current_game = Game.where(:id => params[:game_id]).first
      render 'play'
  end

  # POST /users/1/games/1/get_whoop_card
  def get_whoop_card
      @new_card = Card.new        
      @new_card.save
      chip_ids = [3, 1, 5, 1, 2, 3, 4, 3, 1]
      for i in chip_ids do
        cc_param = {
          :card_id => @new_card.id,
          :chip_id => i
        }
        cc = CardChip.new(cc_param)
        cc.save
      end
      @new_card.update_attributes(:game_id => params[:game_id])
      @new_card.update_attributes(:user_id => params[:user_id])

      flash[:sucess] = "Congrats! You just got a new whoop card!"
      redirect_to user_game_play_path(params[:user_id], params[:game_id])
  end

  # POST /users/1/games/1/get_new_card
  def get_new_card
        @new_card = Card.new        
        @new_card.save

        # TODO:
        # Change the prob if possible
        # Get chips with a certain probability
        chip_ids = []
        chip_ids.push(Chip.where(:game_id => params[:game_id], :level => "higher").order("RANDOM()").limit(1).first.id)
        chip_ids.push(Chip.where(:game_id => params[:game_id], :level => "high").order("RANDOM()").limit(1).first.id)
        medium_chips = Chip.where(:game_id => params[:game_id], :level => "medium").order("RANDOM()").limit(5)
        for i in medium_chips do
          chip_ids.push(i.id)
        end
        chip_ids.push(Chip.where(:game_id => params[:game_id], :level => "lower").order("RANDOM()").limit(1).first.id)
        chip_ids.push(Chip.where(:game_id => params[:game_id], :level => "low").order("RANDOM()").limit(1).first.id)

        chip_ids = chip_ids.shuffle
        # chip_ids = [5,5,5,1,2,3,4,5,5]

        for i in chip_ids do
          cc_param = {
            :card_id => @new_card.id,
            :chip_id => i
          }
          cc = CardChip.new(cc_param)
          cc.save
        end

        @new_card.update_attributes(:game_id => params[:game_id])
        @new_card.update_attributes(:user_id => params[:user_id])

        flash[:sucess] = "Congrats! You just got a new card!"
        redirect_to user_game_play_path(params[:user_id], params[:game_id])
  end

  def send_email
    @user = User.find_by(id: params[:whoop_winner_id])
    if !@user.nil?
        WhoopMailer.send_email(@user).deliver_now
        flash[:sucess] = "Winners are notified!"
    end
    redirect_to score_board_path
  end
end
