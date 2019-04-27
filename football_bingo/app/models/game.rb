class Game < ActiveRecord::Base

	enum state: {upcoming: 0, ongoing: 1, finished: 2 }

    has_one :venue
    has_many :linescores, through: :teams
    has_many :players, through: :teams
    has_many :scores, through: :teams
    has_many :totals, through: :teams
    has_many :fgas, through: :teams
    has_many :drives, through: :teams
    has_many :users, through: :game_users
    has_many :game_users
    has_many :teams
    has_many :cards
    has_many :chips
end
