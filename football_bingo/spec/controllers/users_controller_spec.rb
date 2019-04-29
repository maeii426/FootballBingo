require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#index" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "check win or not" do
    before(:each) do
      @user = create(:user)
      session[:user_id] = @user.id
      session[:user] = @user
      @game = create(:game, id: 2, state: 'ongoing')
      @gu = create(:game_user, user_id: @user.id, game_id: @game.id)
      @card = create(:card, user:@user, game: @game)

      @trans = Translation.create!({:tag => 'penalties_yds', :words => 'Number of penalty yards'})
      @trans.chips.create(:argument => '>', :value => 100, :probablity => 0.7)

      @trans = Translation.create!({:tag => 'firstdowns_no', :words => 'Total first downs'})
      @trans.chips.create(:argument => '>', :value => 30, :probablity => 0.5)

      @trans = Translation.create!({:tag => 'totals_totoff_yards', :words => 'Total offensive yards gained'})
      @trans.chips.create!(:argument => '>', :value => 500, :probablity => 0.2)

      @trans = Translation.create!({:tag => 'fg_made', :words => 'Number of field goals made'})
      @trans.chips.create!(:argument => '>', :value => 2, :probablity => 0.3)

      @trans = Translation.create!({:tag => 'firstdowns_rush', :words => 'Total rushing first downs'})
      @trans.chips.create!(:argument => '>', :value => 10, :probablity => 1.0)


      @chip_ids = [3, 1, 5, 1, 2, 3, 4, 3, 1]
      @chip_ids.each do |i|
        CardChip.create( {:card => @card, :chip_id => i} )
      end

    end

    it "should show 'success' message when  win" do
      subject {@user}
      post subject.check_win
      expect(flash[:success]).to eq('Whoop! You are the winner! Go to check score board!')
      expect(response).to redirect_to(@user)
    end


  end

end
