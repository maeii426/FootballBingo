class Card < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    # has_many :card_chips
    has_many :chips, through: :cards_chips
    # has_and_belongs_to_many :chips
end


# class CardChip < ActiveRecord::Base
#     belongs_to :card_id
#     belongs_to :chip_id
# end