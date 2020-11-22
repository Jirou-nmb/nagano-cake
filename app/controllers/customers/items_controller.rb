class Customers::ItemsController < Customers::ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def index
    @items = Item.all
    @genres = Genre.where(is_active: true)
  end
  
  def show
    @item = Item.find(params[:id])
    @include_tax = (@item.price * 1.1).round
    @cart_item = CartItem.new
  end
end
