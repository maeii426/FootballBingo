class Total < ActiveRecord::Base
    belongs_to :game
    belongs_to :team
    has_many :totalconditions
    has_one :firstdown
    has_one :penalty
    has_one :conversion
    has_one :fumble
    has_one :redzone
    has_one :rush
    has_one :pass
    has_one :rcv
    has_one :punt
    has_one :ko
    has_one :fg
    has_one :pat
    has_one :defense    
    has_one :kr
    has_one :pr
    has_one :fr
end
