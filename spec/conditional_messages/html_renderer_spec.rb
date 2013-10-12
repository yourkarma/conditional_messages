require "conditional_messages/html_renderer"
require "redcarpet"
require "nokogiri"

module ConditionalMessages
  describe HTMLRenderer do

    it "parses markdown without p-tags" do
      expect(subject.html("**hi**")).to eq "<strong>hi</strong>"
    end

    it "removes all kinds of html for plain text" do
      expect(subject.plain("**hi**")).to eq "hi"
    end

  end
end
