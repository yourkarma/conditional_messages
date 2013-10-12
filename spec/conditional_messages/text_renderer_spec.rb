require "conditional_messages/text_renderer"

module ConditionalMessages
  describe TextRenderer do

    it "returns unaltered text for plain text" do
      expect(subject.plain("abc")).to eq "abc"
    end

    it "raises an error for html" do
      expect { subject.html("abc") }.to raise_error "Please require 'redcarpet' and 'nokogiri' to convert to HTML"
    end

  end
end
