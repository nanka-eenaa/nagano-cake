class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    status = @order_detail.status_before_type_cast
    order = @order_detail.order
      if status == 2
        order.update(status: 2)
      elsif order.order_details.count == order.order_details.where(status: 3).count
        order.update(status: 3)
      end
    redirect_to request.referer
  end

  private
    def order_detail_params
      params.require(:order_detail).permit(:status)
    end
end
