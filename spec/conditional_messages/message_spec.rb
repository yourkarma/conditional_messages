require "conditional_messages/message"

module ConditionalMessages
  describe Message do

    subject(:message) { Message.new("source_text") }

    it "has source text" do
      expect(message.source_text).to eq "source_text"
    end

    it "remembers required rules" do
      message.define do
        required { }
        required { }
      end

      expect(message).to have(2).rules
      expect(message.rules.map(&:required?)).to eq [true, true]
    end

    it "remembers optional rules" do
      message.define do
        optional { }
        optional { }
      end
      expect(message).to have(2).rules
      expect(message.rules.map(&:required?)).to eq [false, false]
    end

    it "can apply a context_holder" do
      context_holder = double :context_holder
      applied_message = message.apply(context_holder)
      expect(applied_message.context_holder).to eq context_holder
      expect(applied_message.message).to eq message
    end

  end
end
