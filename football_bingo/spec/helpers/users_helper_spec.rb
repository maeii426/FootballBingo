require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do

  describe "User Play Game Info" do
    before(:each) do
      @user = create(:user, :id => 1,:name => 'xx', :email => 'ga@gmail.com', :role => 'user')
      @game1 = create(:game, id: 1, state: 'finished',hometeam: "TAMU",visteam: "RICE")
      @game2 = create(:game, id: 2, state: 'ongoing',hometeam: "TAMU",visteam: "CLEMSON")
      @gu1=create(:game_user, user_id: @user.id, game_id: @game1.id,:state => "whoop_winner")
      @gu2=create(:game_user, user_id: @user.id, game_id: @game2.id,:state => "instant_winner")
    end
    it "returns played games" do
      user=@user
      game1=@game1
      expect(helper.played_games(user)).to match_array(game1)
    end

    it "returns playing games" do
      user=@user
      gu2=@gu2
      expect(helper.playing_games(user)).to match_array(gu2)
    end

    it "returns whoop games" do
      user=@user
      gu=@gu1
      expect(helper.whoop_games(user)).to match_array(gu)
    end

    it "returns whoop games" do
      user=@user
      gu=@gu2
      expect(helper.instant_games(user)).to match_array(gu)
    end


  end
end
