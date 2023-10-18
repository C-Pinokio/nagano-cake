class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.all
    @item = Item.all
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      flash[:notice] = "商品情報を登録しました"
      redirect_to admin_item_path(@item)
    else
      render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)
      flash[:notice] = "商品情報を変更しました"
      redirect_to admin_item_path(@item)
    else
      render "edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :genre_id, :without_tax, :is_active)
  end
end
