class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # HARDCODED GAME
    @game_path = 'XML/tam.xml'
    #game_helper_load

    @user = User.find(params[:id])
    @cards = Card.where(user_id: @user.id)
    @mygames = GamesUser.where(user: @user)
    # show_user_cards
    render 'show'
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # log in after sign up
      log_in @user
      flash[:success] = "Welcome to the FootballBingo App!"
      redirect_to @user
    else
      render 'new'
    end

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share
    render 'share'
  end

  def check_win
    @user = current_user
    @cards = Card.where(user_id: @user.id)
    win_card_num = check_states_winner_rule

    if win_card_num > 0
      @game = Game.first
      if @game.nil?
        redirect_to @user, notice: "No Game Ongoing"
      else
        @game.update(:whoop_winner=>@user.name)
        redirect_to @user, notice: "Whoop! You are the winner! Go to check score board!"
      end
    else
      redirect_to @user, notice: "Not yet. Good luck is on your way!"
    end


  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
