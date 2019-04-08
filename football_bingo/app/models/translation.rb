class Translation < ActiveRecord::Base
    has_many :conditions
    has_many :chips
end
