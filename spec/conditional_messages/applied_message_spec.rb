require "conditional_messages/applied_message"

module ConditionalMessages
  describe AppliedMessage do

    let(:context_holder) { double :context_holder }

    it "can applies all the rules to a message" do
      rule = double :rule, apply: true
      message = double :message, rules: [ rule ]
      AppliedMessage.new(message, context_holder)
      expect(rule).to have_received(:apply).once
    end

    describe "#all_required_rules_pass?" do

      it "might have an optional rule that fails" do
        applied_message = apply(
          optional_rule(:failing),
          required_rule(:passing),
        )
        expect(applied_message).to have_all_required_rules_passing
      end

      it "is true when there are no rules" do
        applied_message = apply()
        expect(applied_message).to have_all_required_rules_passing
      end

      it "is true when there are only optional rules" do
        applied_message = apply(
          optional_rule(:failing),
          optional_rule(:failing),
        )
        expect(applied_message).to have_all_required_rules_passing
      end

      it "is false when at least one required rule fails" do
        applied_message = apply(
          required_rule(:passing),
          required_rule(:failing),
        )
        expect(applied_message).not_to have_all_required_rules_passing
      end

      it "is true when all required rules pass" do
        applied_message = apply(
          required_rule(:passing),
          required_rule(:passing),
        )
        expect(applied_message).to have_all_required_rules_passing
      end

      def required_rule(passes)
        apply = passes == :passing
        double "required_#{passes}_rule", required?: true, apply: apply
      end

      def optional_rule(passes)
        apply = passes == :passing
        double "optional_#{passes}_rule", required?: false, apply: apply
      end

      def have_all_required_rules_passing
        be_all_required_rules_pass
      end

    end

    describe "#score" do

      it "adds the points for each passing rule" do
        applied_message = apply(
          rule_worth(1, :passing),
          rule_worth(2, :passing),
        )
        expect(applied_message.score).to eq 3
      end

      it "subtracts the points when rules don't pass" do
        applied_message = apply(
          rule_worth(3, :passing),
          rule_worth(7, :failing),
          rule_worth(5, :passing),
        )
        expect(applied_message.score).to eq(3 + 5)
      end

      def rule_worth(points, passes)
        apply = passes == :passing
        double "#{passes}_rule_#{points}_points", points: points, apply: apply
      end

    end

    def apply(*rules)
      message = double :message, rules: rules
      AppliedMessage.new(message, context_holder)
    end

  end
end
