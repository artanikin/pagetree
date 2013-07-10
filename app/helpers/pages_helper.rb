module PagesHelper
  def nested_pages(pages)
    # Перебирает все страницы и для каждой страницы выводит шаблон
    # Если у страницы есть вложенные страницы, то данный метод вызывается снова
    # Вложенные страницы обрамляются DIV`ом
    # Весь код соединяется вместе и возврашается 
    pages.map do |page, sub_pages|
      render(page) + content_tag(:div, nested_pages(sub_pages), class: "nested_pages")
    end.join.html_safe
  end


  def create_link(pages)
    # Принимает массив страниц, расположенных в порядке их вложенности.
    # Записывает их имена в массив и возвращает маршрут для последней страницы.
    link = []
    pages.each do |page|
      link << page.name
    end
    link.join('/')
  end
  

  def formatting_text(s)
    # Формирует в тексте ссылки. Выделяет текст "жирным" и "курсивом"
    format_text_to_italic(format_text_to_bold(urls_to_links(s)))
  end

  def urls_to_links(s)
    # Ищет в тексте строку соответствующую регулярному выражению
    # и возвращает ссылку
    regexp = /\(\((.*?)\s(.*?)\)\)/
    s.gsub! regexp, '<a href="\1">\2</a>'
    s.html_safe
  end

  def format_text_to_bold(s)
    # Ищет в тексте строку соответствующую регулярному выражению
    # и возвращает строку, выделенную жирным
    regexp = /\*\*(.*?)\*\*/
    s.gsub! regexp, '<b>\1</b>'
    s.html_safe
  end

  def format_text_to_italic(s)
    # Ищет в тексте строку соответствующую регулярному выражению
    # и возвращает строку, выделенную курсивом
    regexp = /\\\\(.*?)\\\\/
    s.gsub! regexp, '<i>\1</i>'
    s.html_safe
  end

end
