module ConditionalMessages

  UnknownContextKey = Class.new(KeyError)

  class ContextHolder < BasicObject

    def initialize(context)
      @context = {}
      context.each_pair do |key, value|
        @context[key.to_s] = value
      end
    end

    def method_missing(method, *)
      @context.fetch(method.to_s) {
        ::Kernel.raise UnknownContextKey, "Couldn't find the key `#{method}` in the context you provided:\n\n#{@context.inspect}"
      }
    end

  end
end
