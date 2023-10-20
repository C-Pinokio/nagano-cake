class Public::ItemsController < ApplicationController
  def index
    @item = Item.all
    @genre = Genre.all
    @items = Item.page(params[:page])
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end