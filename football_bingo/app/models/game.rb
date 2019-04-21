class Game < ActiveRecord::Base

	enum state: [:upcoming, :ongoing, :finished]
	after_initialize :set_default_state, :if => :new_record?

	def set_default_state
		self.state ||= :upcoming
	end

	def is_finished?
		self.state == "finished"
	end

	def is_ongoing?
		self.state == "ongoing"
	end

	def is_upcoming?
		self.state == "upcoming"
	end

    has_one :venue
    has_many :linescores
    has_many :players
    has_many :scores
    has_many :totals
    has_many :fgas
    has_many :drives
    has_many :users, through: :games_users
end
