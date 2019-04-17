class Game < ActiveRecord::Base
    has_one :venue
    has_many :linescores
    has_many :players
    has_many :scores
    has_many :totals
    has_many :fgas
    has_many :drives
    has_one :user
    has_many :users
end
