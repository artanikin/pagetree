class PagesController < ApplicationController

  include PagesHelper
  ERROR_MESSAGE = { text: 'Page Not Found', status: 404 }

  def index
    @pages = Page.order("created_at")
  end


  def show
    render ERROR_MESSAGE unless @page = get_page(params[:input_route])
  end


  def new
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
      page_name = get_last_input_param(params)

      if page = Page.find_by_name(page_name)
        return nil unless check_route?(params, page)
      else
        return nil
      end
      page
    end

    def check_route?(params, page)
      params == create_link(page.path.all)
    end

    def get_last_input_param(params)
      params.split('/').last
    end
end
