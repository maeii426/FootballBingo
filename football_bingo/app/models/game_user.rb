class GameUser < ActiveRecord::Base
	enum state: {player: 0, whoop_winner: 1, instant_winner: 2 }

    belongs_to :user
    belongs_to :game
end