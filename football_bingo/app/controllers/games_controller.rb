class GamesController < ApplicationController
  before_action :set_game, only: [:show]
  before_action :set_games, only: [:index, :score_board]
  before_action :set_user_and_game, only: [:get_new_card, :get_whoop_card, :join, :play_game]

  def index
  end

  def show
    visteam = Team.where(:nameid => @game.visteam).first
    hometeam = Team.where(:nameid => @game.hometeam).first
    @vis_totals = Total.where(:team => visteam, :game => @game).first
    @home_totals = Total.where(:team => hometeam, :game => @game).first
    render 'show'
  end

  def score_board
  end

  # POST /users/1/games/1/join
  def join
    @gu = GameUser.where(:user => @user, :game => @game).first
    if @gu.nil?
        flash[:success] = "You play this game for the first time!"
        GameUser.create({:user => @user, :game => @game})
    else
        flash[:warning] = "You can continue this game!"
    end
    redirect_to (user_game_play_path(@user, @game))
  end

  # GET /users/1/games/1/play
  def play_game
      @cards = Card.where(:user => @user, :game => @game)
      render 'play'
  end

  # POST /users/1/games/1/get_whoop_card
  def get_whoop_card
      chip_ids = [4, 1, 1, 1, 1,
                  1, 4, 1, 1, 1, 
                  1, 1, 4, 1, 1,
                  1, 1, 1, 4, 1,
                  1, 1, 1, 1, 4] 
      #for test case:  
      # chip_ids = [1, 1, 1, 1, 4,
      #             1, 1, 1, 4, 1, 
      #             1, 1, 4, 1, 1,
      #             1, 4, 1, 1, 1,
      #             4, 1, 1, 1, 1] 
      get_card(chip_ids)
      redirect_to (user_game_play_path(@user, @game))
  end

  # POST /users/1/games/1/get_new_card
  def get_new_card
      list = { "higher" => 2, "high" => 4, "medium" => 13, "low" => 4, "lower" => 2} # They add up to #chips in one card
      get_card(get_random_chips(list))
      redirect_to (user_game_play_path(@user, @game))
  end

  def send_email
    @user = User.find_by(id: params[:whoop_winner_id])
    if !@user.nil?
        WhoopMailer.send_email(@user).deliver_now
        flash[:sucess] = "Winners are notified!"
    end
    redirect_to score_board_path
  end

  private
    def set_user_and_game
      @user = User.find(params[:user_id])
      @game = Game.find(params[:game_id])
    end

    def set_game
      @game = Game.find(params[:id])
    end

    def set_games
      @games = Game.all
    end

    def get_random_chips(list)
      chip_ids = []
      list.each do |key, value|
        chip_ids += ( Chip.game(@game).with_level(key).random.limit(value).pluck(:id) )
      end
      chip_ids.shuffle
    end

    def get_card(chip_ids)
        @new_card = Card.create
        chip_ids.each do |i|
          CardChip.create( {:card => @new_card, :chip_id => i} )
        end
        @game.cards << @new_card
        @user.cards << @new_card
        flash[:sucess] = "Congrats! You just got a new card!"
    end
end
