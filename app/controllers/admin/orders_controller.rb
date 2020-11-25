class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def today_index
    @orders = Order.where(created_at: Time.now.in_time_zone.all_day)
  end
  
  def index
    @orders = Order.all
  end
  
  def customer_index
    @orders = Order.where()
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id:[@order.id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
  
end
