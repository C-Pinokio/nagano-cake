class Public::SearchesController < ApplicationController
    
  def search
    @word = params[:word]
    @items = Item.looks(params[:word])
  end
end
