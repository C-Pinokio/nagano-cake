class Public::CartItemsController < ApplicationController
  
  def index
    @cart_item = current_customer.cart_items.new
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal}
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "数量が変更されました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "商品を追加できませんでした/数量を選択してください"
      render :index
    end
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      if @cart_item.amount.present?
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
        cart_item.update(amount: cart_item.amount)
        cart_item.save
        @cart_item.destroy
        flash[:notice] = "商品を追加しました"
        redirect_to cart_items_path
      else
        flash[:alert] = "商品を追加できませんでした。/数量を選択してください"
        redirect_to request.referer
      end
    elsif @cart_item.save
      flash[:notice] = "商品を追加しました"
      redirect_to cart_items_path
    else
      flash[:alert] = "商品を追加できませんでした。"
      redirect_to cart_items_path
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "商品を削除しました。"
      redirect_to request.referer
    end
  end
  
  def destroy_all
    
    @cart_items = current_customer.cart_items.all
    if @cart_items.destroy_all
      flash[:notice] = "カート内が空になりました。"
      redirect_to request.referer
    end
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
