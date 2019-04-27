class Card < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    # has_many :card_chips
    has_many :chips, through: :card_chips
    has_many :card_chips
    # has_and_belongs_to_many :chips
end