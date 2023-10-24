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
      else
        @order_details.each do |order_detail|
          if order_detail.making_status == "making"
            @order.update(status: "making")
            break
          end
        end
        if @order_details.all? { |order_detail| order_detail.making_status == "complete" }
          @order.update(status: "prepare")
        end
      end
    end
    redirect_to admin_order_path(@order)
 end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
