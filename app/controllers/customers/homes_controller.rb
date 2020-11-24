class Customers::HomesController < Customers::ApplicationController
  def top
    @genres = Genre.where(is_active: true)
    @items = Item.last(4)
  end

  def about
  end
end
