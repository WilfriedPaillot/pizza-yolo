class CartProductsController < ApplicationController

  def new
    @cart_product = CartProduct.new(
      cart_id: current_user.cart.id,
      product_id: params[:id]
    )
  end

  def create
    @product = Product.find(params[:id])
    unless current_user.cart.products.include?(@product)
      @cart_product = CartProduct.create!(
        cart_id: current_user.cart.id,
        product_id: @product.id,
        quantity: params[:quantity] || 1
      )
    else
      @cart_product = CartProduct.find_by(cart_id: current_user.cart.id, product_id: @product.id)
      @cart_product.update(quantity: @cart_product.quantity + 1)
    end

    respond_to do |format|
      format.html { redirect_to products_path }
      format.js { }
    end
  end

  def update
    @cart_product = CartProduct.find(params[:id])
    new_quantity = params[:increment].present? && params[:increment] == "true" ? @cart_product.increment_quantity : @cart_product.decrement_quantity
    unless new_quantity == 0
      @cart_product.update!(quantity: new_quantity)
    else
      @cart_product.destroy
      redirect_to cart_path(current_user.cart)
    end
    
    respond_to do |format|
      format.html { redirect_to :cart }
      format.js { }
    end
  end
end