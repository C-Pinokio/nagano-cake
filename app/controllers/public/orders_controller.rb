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
    @order.addresses = @customer.address
    @order.name = @customer.last_name + @customer.first_name
    @postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_pay = @total + @postage
    
    
  end
  
  def complete
    # 文字表示のみのため不要
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    
    if @order.save
      current_customer.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.amount = cart_item.amount
        @order_detail.include_tax = cart_item.item.add_tax_price 
        @order_detail.save
      end
      redirect_to complete_orders_path
      current_customer.cart_items.destroy_all
    else
      flash.now[:notice] = "入力情報を確認してください。"
      redirect_to new_order_path
    end
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
