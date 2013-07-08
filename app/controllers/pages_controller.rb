class PagesController < ApplicationController

  def index
    @pages = Page.order("created_at")
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(parent_id: params[:parent_id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to pages_url
    else
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    # TODO: 1. Заменить render
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      render :show
    else
      render :edit
    end
  end
end
