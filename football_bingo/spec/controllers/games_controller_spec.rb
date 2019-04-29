require 'rails_helper'
RSpec.describe GamesController, type: :controller do

    it 'sends an email' do
      subject {:game}
      get :send_email
      expect(response).to redirect_to '/score_board'
    end



end
