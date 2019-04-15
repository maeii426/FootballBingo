class Venue <  ActiveRecord::Base
    belongs_to :game
    validates :gameid, presence: true, uniqueness: { case_sensitive: false }
end
