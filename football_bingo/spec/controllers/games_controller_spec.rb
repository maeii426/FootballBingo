require 'rails_helper'
RSpec.describe GamesController, type: :controller do

  describe "#send-email" do
    it 'sends an email' do
      subject {:game}
      get :send_email
      expect(response).to redirect_to '/score_board'
    end
  end

  describe "#show" do
    before(:each) do
      @game = create(:game, id: 1, state: 'ongoing',hometeam: "TAMU",visteam: "RICE")
      @visteam = create(:team, name: "TAMU", nameid: "TAMU")
      @hometeam = create(:team, name: "RICE", nameid: "RICE")
      FactoryBot.create(:total, :team => @hometeam, :game => @game)
      FactoryBot.create(:total, :team => @visteam, :game => @game)
    end

    it 'show game details' do
      post :show,  params: { id: @game.id }
      expect(response).to render_template("games/show")
    end
  end

  describe "#play_game" do
    before(:each) do
      @user = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'admin')
      @game = create(:game, id: 2, state: 'ongoing')
      @card = create(:card, user:@user, game: @game)
    end
    it 'play game details' do
      post :play_game,  params: {:user_id => @user.id, :game_id => @game.id}
      expect(response).to render_template("games/play")
    end
  end

  describe "#join the game" do
    before(:each) do
      @user = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'admin')
      @game = create(:game, id: 2, state: 'ongoing')
      @gu = create(:game_user, user_id: @user.id, game_id: @game.id)
    end
    it 'redirect to user game play page' do
      post :join , params: {:user_id => @user.id, :game_id => @game.id}
      expect(flash[:warning]).to eq('You can continue this game!')
    end
  end

  describe "#get_whoop_card" do
    before(:each) do
      @user = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'admin')
      @game = create(:game, id: 2, state: 'ongoing')
    end
    it 'show game details' do
      get :get_whoop_card , params: {:user_id => @user.id, :game_id => @game.id}
      response.should redirect_to(user_game_play_path(@user, @game))
    end
  end


  describe "#get_new_card" do
    before(:each) do
      @user = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'admin')
      @game = create(:game, id: 2, state: 'ongoing')
    end
    it 'show game details' do
      get :get_new_card , params: {:user_id => @user.id, :game_id => @game.id}
      response.should redirect_to(user_game_play_path(@user, @game))
    end
  end

end
