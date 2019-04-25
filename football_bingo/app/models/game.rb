class Game < ActiveRecord::Base

	enum state: {upcoming: 0, ongoing: 1, finished: 2 }

    has_one :venue
    has_many :linescores
    has_many :players
    has_many :scores
    has_many :totals
    has_many :fgas
    has_many :drives
    has_many :users, through: :game_users
    has_many :game_users
    has_many :cards
    has_many :chips
end
