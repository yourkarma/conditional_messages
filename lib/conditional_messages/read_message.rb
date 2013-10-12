module ConditionalMessages
  class ReadMessage

    attr_reader :context, :message, :renderer

    def initialize(context, message, renderer)
      @context  = context
      @message = message
      @renderer = renderer
    end

    def text
      renderer.plain(applied_text)
    end

    def html
      renderer.html(applied_text)
    end

    def source_text
      message.source_text
    end

    def applied_text
      @applied_text ||= source_text % context
    end

  end
end
