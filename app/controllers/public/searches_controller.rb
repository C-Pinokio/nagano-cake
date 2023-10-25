class Public::SearchesController < ApplicationController
    
  def search
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
    @items_all = @items.page(params[:page])
  end
end
