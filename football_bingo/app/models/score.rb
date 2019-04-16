class Score < ApplicationRecord
    belongs_to :game
    belongs_to :team
end
