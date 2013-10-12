module ConditionalMessages
  UndefinedRuleError = Class.new(ArgumentError)
  class Rule

    attr_reader :options, :condition

    def initialize(options = {}, &condition)
      @options   = options
      @condition = condition || raise(UndefinedRuleError)
    end

    def required?
      options.fetch(:required) { false }
    end

    def points
      options.fetch(:points) { default_points }
    end

    def default_points
      required? ? 100 : 10
    end

    def apply(context)
      context.instance_eval(&condition)
    end

  end
end
