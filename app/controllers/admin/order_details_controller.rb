class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    order_detail = OrderDetail.find(params[:id])
  end
end