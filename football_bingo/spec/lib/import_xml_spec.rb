require 'rails_helper'
include ImportXML

describe ImportXML do


    describe "parse xml correct" do
      it "should have name" do
        get_xml_game("./XML/tam.xml")
      end
    end

end
