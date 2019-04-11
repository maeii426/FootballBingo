class Chip < ActiveRecord::Base
    belongs_to :translation
    # has_many :card_chips
    # has_many :cards, through: :card_chips
    has_and_belongs_to_many :cards
    


    def translate
        translation = Translation.find(translation_id)
        @conditional = translation.tag
        in_words = translation.words
        state_of_chip = check_parse
        if state_of_chip
            return in_words + argument + value.to_s, state_of_chip
        end
        
        return in_words + argument + value.to_s, state_of_chip
    end
    
    def check
        
    end
    
    def check_parse
       # Fetch and parse HTML document
        doc = Nokogiri::XML(open(Rails.root + 'XML/tam.xml'))    #('https://nokogiri.org/tutorials/installing_nokogiri.html'))
 
        # ASSUMPTIONS
            # no '_' tokens in the XML tag
            # right now - tags that should have only one instance are assumed to have only one instance
            # ********* CONDITION IS >
        tokens = @conditional.split('_', 2)
        doc_content = doc.at(tokens[0])
        if doc_content
            entries = doc_content.to_s
            if entries.include?(tokens[1])
                doc_value = entries.match(/#{tokens[1]}="([^"]*)"/).captures
                #doc_value = entries.match(/(?<#{tokens[1]}>\w+)/)
                if value <= doc_value[0].to_f
                    return true
                end
            end
        end
        false
    end

end
