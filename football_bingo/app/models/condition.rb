class Condition < ActiveRecord::Base
    belongs_to :translation
    belongs_to :game
end
