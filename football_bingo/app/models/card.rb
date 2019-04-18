class Card < ActiveRecord::Base
    belongs_to :user
    # has_many :card_chips
    # has_many :chips, through: :card_chips
    has_and_belongs_to_many :chips
    #validates :user_id, presence: true 
    #validates :content, presence: true, length: {maximum: 140}
    
end


# class CardChip < ActiveRecord::Base
#     belongs_to :card_id
#     belongs_to :chip_id
# end