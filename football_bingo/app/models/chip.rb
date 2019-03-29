class Chip < ActiveRecord::Base
    def translate
        return conditional + argument + value.to_s
    end
end
