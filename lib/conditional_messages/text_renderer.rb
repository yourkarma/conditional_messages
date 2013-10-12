module ConditionalMessages
  class TextRenderer

    def html(text)
      raise "Please require 'redcarpet' and 'nokogiri' to convert to HTML"
    end

    def plain(text)
      text
    end

  end
end
