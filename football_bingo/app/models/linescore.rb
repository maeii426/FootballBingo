class Linescore < ActiveRecord::Base
    belongs_to :game
    belongs_to :team
    has_many :linescoreconditions
end
