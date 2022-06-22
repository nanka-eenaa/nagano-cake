class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_total_price = @order.total_payment - @order.postage
    @order_details = @order.order_details.all
  end

  def update
  end
end
