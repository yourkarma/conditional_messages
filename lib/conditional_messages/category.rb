require "conditional_messages/message"

module ConditionalMessages
  class Category

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def define(*args, &definition)
      instance_eval(*args, &definition)
      self
    end

    def message(source_text, &definition)
      message = Message.new(source_text)
      message.define(&definition) if definition
      messages << message
      message
    end

    def messages
      @messages ||= []
    end

    def apply(context_holder)
      messages.map { |message| message.apply(context_holder) }
    end

  end
end
