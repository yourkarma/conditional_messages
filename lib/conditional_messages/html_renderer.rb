module ConditionalMessages
  class HTMLRenderer

    def html(text)
      markdown.render(text).strip.sub(/\A<p>/,'').sub(/<\/p>\z/, '')
    end

    def plain(text)
      Nokogiri::HTML(html(text)).content
    end

    private

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, autolink: true, no_intra_emphasis: true, strikethrough: true, lax_spacing: true, underline: true, footnotes: true, space_after_headers: true, tables: true)
    end

    def renderer
      @renderer ||= Redcarpet::Render::HTML.new(no_styles: true)
    end

  end
end
