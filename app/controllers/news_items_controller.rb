class NewsItemsController < ApplicationController
  def index
    set_crumb([["News", "/news"], "TRC News"])
    @news_items = NewsItem.find(:all)

  end

  def show
    @news_item = NewsItem.find(params[:id])
    set_crumb([["News", "/news"], ["TRC News", news_items_path], @news_item.title])
    @title = "News Items"
  end
end
