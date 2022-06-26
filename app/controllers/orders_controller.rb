class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.js {}
    end
  end
end
