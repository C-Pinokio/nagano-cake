class Public::SearchesController < ApplicationController
    
  def search
    genre_id = params[:genre_id]
    @item_searches = Item.where(genre_id: genre_id)
    @item_searches_all =  @item_searches.page(params[:page])
  end
  
  def item_search
    @word = params[:word]
    @items = Item.looks(params[:word])#検索ワードparams[:word]を参照してデータを検索し、インスタンス変数@ItemsにItemモデル内での検索結果を代入。
  end
end
