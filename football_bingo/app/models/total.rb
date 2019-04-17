class Total < ActiveRecord::Base
    belongs_to :game
    belongs_to :team
    has_many :totalconditions
    has_one :score
    has_one :drife
    has_one :fga
end
