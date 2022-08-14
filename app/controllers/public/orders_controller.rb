class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_total_price = @order.total_payment - @order.postage
    @order_details = @order.order_details.all
  end

  def check
    @select_address = params[:order][:select_address]
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.sub_total }
    @order.total_payment = @total_price + @order.postage
    if @select_address == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    elsif @select_address == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif @select_address == "2"
    end
    if @order.invalid?
      @addresses = current_customer.addresses.all
      render :new
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items
    select_address = params[:order][:select_address]
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.quantity = cart_item.quantity
        @order_detail.price = cart_item.item.tax_price
        @order_detail.save
      end

      if select_address == "2"
        address = current_customer.addresses.new
        address.name = @order.name
        address.post_code = @order.post_code
        address.address = @order.address
        address.save
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
