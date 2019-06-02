class MarkdownParser
  require 'redcarpet'
  require './lib/custom_renderer'
  def initialize(markdown)
    @markdown = markdown
  end

  def markdown_to_html
    processor.render(@markdown).html_safe
  end

  def processor
    Redcarpet::Markdown.new(renderer, extensions = { tables: true, quotes: true,
                                                     highlight: true, autolink: true })
  end

  def renderer
    # Redcarpet::Render::Safe
    CustomRenderer::SafeMentionsRenderer
  end
end
