module PagesHelper
  def nested_pages(pages)
    pages.map do |page, sub_pages|
      render(page) + content_tag(:div, nested_pages(sub_pages), class: "nested_pages")
    end.join.html_safe
  end

  def create_link(pages)
    link = []
    pages.each do |page|
      link << page.name
    end
    link.join('/')
  end
  

  def formatting_text(s)
    format_text_to_italic(format_text_to_bold(urls_to_links(s)))
  end

  def urls_to_links(s)
    s.gsub! /\(\((.*?)\s(.*?)\)\)/, '<a href="\1">\2</a>'
    s.html_safe
  end

  def format_text_to_bold(s)
    s.gsub! /\*\*(.*?)\*\*/, '<b>\1</b>'
    s.html_safe
  end

  def format_text_to_italic(s)
    s.gsub! /\\\\(.*?)\\\\/, '<i>\1</i>'
    s.html_safe
  end

end
