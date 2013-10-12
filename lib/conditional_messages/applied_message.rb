require "conditional_messages/applied_rule"

module ConditionalMessages
  class AppliedMessage

    attr_reader :message, :context_holder, :applied_rules

    def initialize(message, context_holder)
      @message = message
      @context_holder = context_holder
      @applied_rules = apply_rules
    end

    def all_required_rules_pass?
      applied_rules.all?(&:required_pass?)
    end

    def score
      applied_rules.map(&:score).inject(:+)
    end

    def source_text
      message.source_text
    end

    private

    def apply_rules
      message.rules.map { |rule| AppliedRule.new(rule, context_holder) }
    end

  end
end
