class Linescore < ApplicationRecord
    belongs_to :game
    has_many :conditions
end
