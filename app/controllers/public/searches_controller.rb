class Public::SearchesController < ApplicationController
    
  def search
    genre_id = params[:genre_id]
    @item_searches = Item.where(genre_id: genre_id)
    @item_searches_all =  @item_searches.page(params[:page])
  end
end
