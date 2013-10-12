require "conditional_messages/rule"
require "conditional_messages/applied_message"

module ConditionalMessages
  class Message

    attr_reader :source_text

    def initialize(source_text)
      @source_text = source_text
    end

    def define(&definition)
      instance_eval(&definition)
    end

    def required(options = {}, &condition)
      rule(options.merge(required: true), &condition)
    end

    def optional(options = {}, &condition)
      rule(options.merge(required: false), &condition)
    end

    def rule(options = {}, &condition)
      rule = Rule.new(options, &condition)
      rules << rule
      rule
    end

    def rules
      @rules ||= []
    end

    def apply(context_holder)
      AppliedMessage.new(self, context_holder)
    end

  end
end
