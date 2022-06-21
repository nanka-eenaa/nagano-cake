class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def index
  end

  def check
  end

  def create
  end

  def thanks
  end
end
