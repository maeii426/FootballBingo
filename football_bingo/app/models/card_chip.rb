class CardChip < ActiveRecord::Base
    belongs_to :card
    belongs_to :chip
end