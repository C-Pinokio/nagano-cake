class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @cart_items = @customer.cart_items
    @postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_pay = @total + @postage
    # select_addressで選択された番号をもとに住所を変更する。
    if params[:order][:select_address] == "0"
      @order.addresses = @customer.address
      @order.postcode = @customer.postcode
      @order.name =  @customer.last_name + @customer.first_name
    elsif params[:order][:select_address] == "1"
      address = Address.find(params[:order][:address_id])
      @order.addresses = address.address
      @order.postcode = address.postcode
      @order.name = address.name
    elsif params[:order][:select_address] == "2"
      @order.addresses =params[:order][:address]
      @order.postcode = params[:order][:postcode]
      @order.name = params[:order][:name]
    end
    if @order.addresses.blank? || @order.postcode.blank? || @order.name.blank?
      flash[:alert] = "新しいお届け先を入力してください。"
      redirect_to new_order_path
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
    @orders_all = current_customer.orders.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :total_price, :name, :postcode, :addresses, :payment_method, :postage)
  end
end
