class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8)
    @all_item = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
