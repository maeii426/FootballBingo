class Game < ActiveRecord::Base
    has_many :conditions
    has_one :venue
    has_one :linescore
end
