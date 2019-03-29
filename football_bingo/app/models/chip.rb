class Chip < ActiveRecord::Base
    def translate
        if check
            return conditional + argument + value.to_s + ' ' + check.to_s
        end
        
        return conditional + argument + value.to_s + ' ' + check.to_s
    end
    
    def check
       # Fetch and parse HTML document
        doc = Nokogiri::XML(open(Rails.root + 'XML/tam.xml'))    #('https://nokogiri.org/tutorials/installing_nokogiri.html'))
 
        # ASSUMPTIONS
            # no '_' tokens in the XML tag
            # right now - tags that should have only one instance are assumed to have only one instance
            # ********* CONDITION IS >
        tokens = conditional.split('_', 2)
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
