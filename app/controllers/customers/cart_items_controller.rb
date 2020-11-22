class Customers::CartItemsController < ApplicationController
  
  def create
    @customer = current_customer
    @cart_item = @customer.cart_item
    @item.customer_id = (current_customer.id)
    if @cart_item.save
      flash[:notice] = "カートに追加しました"
      @cart_items = Item.all
      redirect_to "/customers/#{@cart_items.id}"
    else
      
    end
     
  end
  
  def index
  end

end