class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + subtotal}
  end
  
  def update
  end
  
  def create
  end
  
  def destroy
  end
  
  def destroy_all
  end
end
