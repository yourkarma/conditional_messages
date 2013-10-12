require "conditional_messages/read_message"
require "conditional_messages/find_message"
require "conditional_messages/context_holder"
require "conditional_messages/html_renderer"
require "conditional_messages/text_renderer"

module ConditionalMessages
  class ReadCategory

    attr_reader :category

    def initialize(category)
      @category = category
    end

    def for(context)
      context_holder = ContextHolder.new(context)
      applied_message = FindMessage.for(context_holder, category)
      ReadMessage.new(context, applied_message, renderer.new)
    end

    def renderer
      if defined?(Redcarpet) && defined?(Nokogiri)
        HTMLRenderer
      else
        TextRenderer
      end
    end

  end
end
