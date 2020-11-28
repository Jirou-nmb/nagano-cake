class Customers::OrdersController < Customers::ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @address = Address.new
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @order_detail = OrderDetail.new
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif params[:order][:address_option] == "1"
      @address_id = params[:order][:address_id].to_i
      @address = Address.find(@address_id)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] == "2"
      @address = Address.new(address_params)
      @address.customer_id = current_customer.id
      @address.save
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      @address.save
    end

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.all.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price * 110 / 100
      order_detail.save
    end

    current_customer.cart_items.destroy_all

    redirect_to thanks_orders_path

  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:shipping_cost, :total_payment,
    :payment_method, :name, :postal_code, :address, :status)
  end

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
