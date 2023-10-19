class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
    
  end
  
  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = @customer.cart_items
    @order.postcode = @customer.postcode
    @order.address = @customer.address
    @order.name = @customer.last_name
    @postage = 800
    @total = @cart_itmes.inject(0) { |sum, item| sum + }
    
    
  end
  
  def complete
    # 文字表示のみのため不要
  end
  
  def create
  end
  
  def index
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :total_price, :name, :postcode, :addresses, :payment_method, :postage)
  end
end
