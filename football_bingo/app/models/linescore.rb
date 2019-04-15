class Linescore < ActiveRecord::Base
    belongs_to :game
    has_many :conditions
end
