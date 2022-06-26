class OrderProductsController < ApplicationController
  def show
    @order_products = OrderProduct.where(order_id: params[:order_id])
    respond_to do |format|
      format.html { render :show }
      format.js {}
    end
  end
end
