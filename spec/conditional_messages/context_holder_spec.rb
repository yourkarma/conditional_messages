require "conditional_messages/context_holder"

module ConditionalMessages
  describe ContextHolder do

    let(:context) { { :a => "x", "b" => "y" } }

    subject(:holder) { ContextHolder.new(context) }

    it "gives access to a hash" do
      expect(holder.a).to eq "x"
    end

    it "raises an exception when the key wasn't present" do
      expect{holder.c}.to raise_error UnknownContextKey, <<-MSG.gsub(/\n\s+/m, "\n\n").strip
        Couldn't find the key `c` in the context you provided:

        {"a"=>"x", "b"=>"y"}
      MSG
    end

    it "doesn't care about strings or symbols in the context" do
      expect(holder.b).to eq "y"
    end

  end
end
