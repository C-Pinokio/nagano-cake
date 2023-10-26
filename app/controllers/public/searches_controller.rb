class Public::SearchesController < ApplicationController
    
  def search
    genre_id = params[:genre_id]
    @item_searches = Item.where(genre_id: genre_id)
    @item_searches_all =  @item_searches.page(params[:page])
    @word = params[:word]
    @items = Item.looks(params[:word])#検索ワードparams[:word]を参照してデータを検索し、インスタンス変数@ItemsにItemモデル内での検索結果を代入。
    @genres = Genre.all
  end
  
  def admin_search
    @range = params[:range]
    @word = params[:word]
    if @range == "顧客"
      @records = Customer.search_by_full_name(@word)
    else
      @records = Item.search_for(@word)
    end
  end
  
end
