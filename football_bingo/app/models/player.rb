class Player < ApplicationRecord
    belongs_to :game
    belongs_to :team
    has_many :playerconditions
end
