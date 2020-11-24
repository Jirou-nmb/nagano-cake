class Customers::CartItemsController < ApplicationController
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       flash[:notice] = "Item was successfully added to cart."
       redirect_to cart_items_path
    elsif @cart_item.save
          flash[:notice] = "New Item was successfully added to cart."
          redirect_to cart_items_path
    else
          render 'customers/items/show'
    end
  end
  
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "商品の数量を変更しました。"
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "商品を削除しました。"
    redirect_to cart_items_path
  end
  
  def all_destroy
    current_customer.cart_items.destroy_all
    flash[:alert] = "カート内の商品を全て削除しました。"
    redirect_to cart_items_path
  end

private
  def cart_item_params
      params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
  
end