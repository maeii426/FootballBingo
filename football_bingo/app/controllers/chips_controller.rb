class ChipsController < ApplicationController

    def self.translate
        return conditional + argument + value.to_s
    end
end
