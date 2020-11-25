class Customers::OrdersController < Customers::ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
    @address = Address.new
    @addresses = @customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
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
    end

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to thanks_orders_path

  end

  def thanks
  end

  def index
  end

  def show
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
