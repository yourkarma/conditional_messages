require "conditional_messages/read_message"

module ConditionalMessages
  describe ReadMessage do

    let(:context) { { source: "applied" } }
    let(:message) { double :message, source_text: "the %{source} text" }
    let(:renderer) { double :renderer, html: "html", plain: "plain text" }
    let(:reader) { ReadMessage.new(context, message, renderer) }

    it "has has the messages source text" do
      expect(reader.source_text).to eq "the %{source} text"
    end

    it "renders plain text" do
      expect(reader.text).to eq "plain text"
      expect(renderer).to have_received(:plain).with("the applied text")
    end

    it "renders html" do
      expect(reader.html).to eq "html"
      expect(renderer).to have_received(:html).with("the applied text")
    end

  end
end
