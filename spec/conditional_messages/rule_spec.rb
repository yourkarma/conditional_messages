require "conditional_messages/rule"

module ConditionalMessages
  describe Rule do

    it "can be required" do
      rule = Rule.new(required: true) {}
      expect(rule).to be_required
    end

    it "is not required by default" do
      rule = Rule.new { foo == 10 }
      expect(rule).not_to be_required
    end

    it "requires a condition block" do
      expect{Rule.new}.to raise_error UndefinedRuleError
    end

    it "can evaluate a condition in a context" do
      context = double :context, some_method: "value"
      rule = Rule.new do
        some_method
      end
      expect(context).not_to have_received(:some_method)
      rule.apply(context)
      expect(context).to have_received(:some_method)
    end

    it "has points to calculate a score by default" do
      rule = Rule.new(required: true){}
      expect(rule.points).to eq 100
      rule = Rule.new(required: false){}
      expect(rule.points).to eq 10
    end

    it "allows points to be configured" do
      rule = Rule.new(points: 55){}
      expect(rule.points).to eq 55
    end

  end
end
