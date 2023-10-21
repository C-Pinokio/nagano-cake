class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
    @orders = Order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @total = @order.order_details.inject(0) {|sum, order_detail| sum + order_detail.total_price }
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      if @order.status == "check"
        @order_details.update_all(making_status: "wait")
      end
      if @order_details.making_status == "making"
        @order.update(status: "making")
      end
      if @order_details.making_status.all == "making"
        @order.update(status: "prepare")
      end
    redirect_to admin_order_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
