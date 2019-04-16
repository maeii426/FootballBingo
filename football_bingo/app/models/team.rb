class Team < ActiveRecord::Base
	has_many :linescores
    has_many :players
    has_many :scores
    has_many :totals
    has_many :fgas
    has_many :drives
    
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :nameid, presence: true, uniqueness: { case_sensitive: false }
end
