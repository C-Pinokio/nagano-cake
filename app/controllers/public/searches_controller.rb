class Public::SearchesController < ApplicationController
    
  def search
  end
  
  def item_search
    @word = params[:word]
    @items = Item.looks(params[:word])#検索ワードparams[:word]を参照してデータを検索し、インスタンス変数@ItemsにItemモデル内での検索結果を代入。
  end
end
