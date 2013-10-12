module ConditionalMessages
  class AppliedRule

    attr_reader :rule, :context_holder

    def initialize(rule, context_holder)
      @rule           = rule
      @context_holder = context_holder
      @outcome        = rule.apply(context_holder)
    end

    def score
      if pass?
        points
      else
        0
      end
    end

    def required?
      rule.required?
    end

    def pass?
      @outcome
    end

    def required_pass?
      if required?
        pass?
      else
        true
      end
    end

    def points
      rule.points
    end

  end
end
