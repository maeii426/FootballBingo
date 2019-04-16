class Translation < ActiveRecord::Base
    has_many :linescoreconditions
    has_many :playerconditions
    has_many :totalconditions
    has_many :chips
end
