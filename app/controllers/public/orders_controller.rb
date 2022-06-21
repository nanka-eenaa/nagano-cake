class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def index
  end

  def check
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.sub_total }
    @order.total_payment = @total_price + @order.postage
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif  params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif  params[:order][:select_address] == "2"
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.quantity = cart_item.quantity
        @order_detail.price = cart_item.item.tax_price
        @order_detail.save
      end
      @cart_items.destroy_all
      redirect_to order_thanks_path
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method,:post_code,:address,:name,:postage,:total_payment)
  end
end
