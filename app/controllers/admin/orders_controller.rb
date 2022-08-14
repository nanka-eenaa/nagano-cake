class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_total_price = @order.total_payment - @order.postage
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    order_details = @order.order_details.all
    status = @order.status_before_type_cast
    if status == 1
      order_details.update_all(status: 1)
    end
    redirect_to request.referer
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
end
