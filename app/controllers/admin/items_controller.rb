class Admin::ItemsController < Admin::ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品の登録が完了しました"
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @include_tax = (@item.price * 1.1).round
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品の更新を完了しました"
    else
      render :edit
    end
  end

  private
    def item_params
      params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
    end
end
