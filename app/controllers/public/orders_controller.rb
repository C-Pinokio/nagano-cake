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
    
    # select_addressで選択された番号をもとに住所を変更する。
    if params[:order][:select_address] == 0
      @order.postcode = @customer.postcode
      @order.addresses = @customer.address
      @order.name =  @customer.last_name + @customer.first_name
    elsif params[:order][:select_address] == 1
      address = Address.find(params[:order][:address_id])
      @order.addresses = address.address
      @order.postcode = address.postcode
      @order.name = address.name
    else params[:order][:select_address] == 2
      address = params[:order][:postcode][:address][:name]
      @order.addresses = address.address
      @order.postcode = address.postcode
      @order.name = address.name
    end
    
      
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
    @orders_all = current_customer.orders.all
    
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :total_price, :name, :postcode, :addresses, :payment_method, :postage)
  end
end
