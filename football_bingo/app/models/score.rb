class Score < ActiveRecord::Base
self.inheritance_column = :foo 
# type is restricted word, you can't use it as a column name in ActiveRecord models
    belongs_to :game
    belongs_to :team
end
