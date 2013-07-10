class PagesController < ApplicationController

  include PagesHelper
  ERROR_MESSAGE = { text: 'Page Not Found', status: 404 }

  def index
    @pages = Page.order("created_at")
    @p = Page.find([2])
    @link = create_link(@pages.last.path.all)
    # @link = create_link(@p)
  end


  def show
    page_name = get_last_input_param(params[:input_route])

    if @page = Page.find_by_name(page_name)
      render ERROR_MESSAGE unless check_route?(params[:input_route], @page)
    else
      render ERROR_MESSAGE
    end
  end


  def new
    # TODO: 1. Рассмотреть возможность рефакторинга этого метода
    if params[:input_route]
      page_name = get_last_input_param(params[:input_route]) 

      if parent = Page.find_by_name(page_name)
        render ERROR_MESSAGE unless check_route?(params[:input_route], parent)
        @page = Page.new(parent_id: parent.id)
      else
        render ERROR_MESSAGE
      end
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
    page_name = get_last_input_param(params[:input_route]) 

    if @page = Page.find_by_name(page_name)
        render ERROR_MESSAGE unless check_route?(params[:input_route], @page)
      else
        render ERROR_MESSAGE
    end
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

    def check_route?(params, page)
      params == create_link(page.path.all)
    end

    def get_last_input_param(params)
      params.split('/').last
    end
end
