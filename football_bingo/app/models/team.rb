class Team < ActiveRecord::Base
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :nameid, presence: true, uniqueness: { case_sensitive: false }
end
