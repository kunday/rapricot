module Rapricot
  def render(document)
    case document
      when Array then render_element(document)
      else document.to_s
    end
  end

  def render_element(element)
    tag        = element.shift.to_s
    attributes = render_attributes(element)
    content    = element.map{|c| render(c) + "\n" }.join

    wrap_in_tag(tag, attributes, content)
  end

  def wrap_in_tag(tag, attributes, content)
    "<#{tag}#{attributes}>\n" + indent_lines(content) + "</#{tag}>"
  end

  def indent_lines(lines)
    lines.each_line.map{|l| "  " + l }.join
  end

  def render_attributes(element)
    case element.first
    when Hash
      element.shift.map do |key, value|
        " #{key}=\"#{value}\""
      end.join
    else
      ""
    end
  end

  # This allows all methods can be called as Rapricot.method. A class may still
  # include Rapricot and call the method directly without the namespace prefix.
  class << self
    include Rapricot
  end
end

