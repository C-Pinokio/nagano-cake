class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)
    
    if @order_details.any? { |order_detail| order_detail.making_status == "making" }
      @order.update(status: "making")
    end
    
    if @order_details.all? { |order_detail| order_detail.making_status == "complete" }
      @order.update(status: "prepare")
    end
    redirect_to admin_order_path(@order)
  end

  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
