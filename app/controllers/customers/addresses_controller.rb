class Customers::AddressesController < Customers::ApplicationController
  def index
  end

  def create
    @address = Address.new(address_params)
    @address.save
    rediect_to addresses_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
