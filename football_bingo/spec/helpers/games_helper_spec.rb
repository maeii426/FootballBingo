require 'rails_helper'

RSpec.describe GamesHelper, type: :helper do

  describe "Get Game states" do
    it "returns ongoing states" do
      game = build(:game, :id => 1, :state => 'ongoing')
      expect(helper.get_state(game)).to eq("Ongoing")
    end
    it "returns states" do
      game = build(:game, :id => 1, :state => 'finished')
      expect(helper.get_state(game)).to eq("Finished")
    end
    it "returns states" do
      game = build(:game, :id => 1, :state => 'upcoming')
      expect(helper.get_state(game)).to eq("Upcoming")
    end
  end

  describe "Check Winner" do
    before(:each) do
      @user1 = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'user')
      @user2 = create(:user, :id => 2,:name => 'xxx', :email => 'gax@gmail.com', :role => 'user')
      @game = create(:game, id: 2, state: 'ongoing')
      create(:game_user, user_id: @user1.id, game_id: @game.id,:state => "whoop_winner")
      create(:game_user, user_id: @user2.id, game_id: @game.id,:state => "instant_winner")
    end
    it "returns whoop states" do
      user=@user1
      game=@game
      expect(helper.check_winner(game,user)).to eq("Whoop Winner!")
    end

    it "returns instant states" do
      user=@user2
      game=@game
      expect(helper.check_winner(game,user)).to eq("Instant Winner!")
    end

  end

end
