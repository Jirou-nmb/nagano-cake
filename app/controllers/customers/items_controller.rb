class Customers::ItemsController < Customers::ApplicationController
  before_action :authenticate_customer!, only: [:show]
  
  def index
    @items = Item.all
    @genres = Genre.where(is_active: true)
  end
  
  def sort
    @items = Item.where(genre_id: params[:genre_id])
    @genres = Genre.where(is_active: true)
    @genre = Genre.find(params[:genre_id])
  end
  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.where(is_active: true)
    @include_tax = (@item.price * 1.1).round
    @cart_item = CartItem.new
  end
  
  private
  def item_params
      params.require(:item).permit(:genre_id, :name, :introduction, :price, :image_id, :is_active)
  end
  
end