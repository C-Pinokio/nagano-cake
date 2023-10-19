class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def confirm
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
