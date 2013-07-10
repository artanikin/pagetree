class PagesController < ApplicationController

  include PagesHelper
  ERROR_MESSAGE = { text: 'Page Not Found', status: 404 }

  def index
    @pages = Page.order("created_at")
  end


  def show
    # Возвращает @page, если маршрут указан верно
    render ERROR_MESSAGE unless @page = get_page(params[:input_route])
  end


  def new
    # Возвращает новый объект @page
    # Если добавляется подстраница к существующей странице, то вместе с объектом
    # @page передается id родителя
    if params[:input_route]
      render ERROR_MESSAGE unless parent = get_page(params[:input_route])
      @page = Page.new(parent_id: parent.id)
    else
      @page = Page.new()
    end
  end


  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to show_page_path(create_link(@page.path.all))
    else
      render 'new'
    end
  end


  def edit
    # Возвращает существующий объект @page 
    render ERROR_MESSAGE unless @page = get_page(params[:input_route])
  end


  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to show_page_path(create_link(@page.path.all))
    else
      render :edit
    end
  end


  private

    def get_page(params)
      # Получение последнего элемента из параметров
      page_name = get_last_input_param(params)

      # Проверка существования страницы с именем "page_name"
      if page = Page.find_by_name(page_name)
        # Проверка, правильно ли был введен маршрут для страницы
        return nil unless check_route?(params, page)
      else
        return nil
      end
      page
    end

    def check_route?(params, page)
      # Сравнение введенного маршрута пользователем и реального маршрута страницы
      # Метод "create_link" расположен в модуле "PagesHelper"
      params == create_link(page.path.all)
    end

    def get_last_input_param(params)
      # Разбивает строку параметров в массив и возвращает последний элемент
      params.split('/').last
    end
end
