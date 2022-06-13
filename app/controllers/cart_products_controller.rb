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
      )
    else
      @cart_product = CartProduct.find_by(cart_id: current_user.cart.id, product_id: @product.id)
      @cart_product.update(quantity: @cart_product.quantity + 1)
    end

    respond_to do |format|
      format.html { redirect_to cart_path(current_user.cart) }
    end
  end

  def update
    @cart = Cart.find(current_user.cart.id)
    @product = Product.find(params[:id])
    @cart_product = CartProduct.find_by(cart_id: @cart.id, product_id: @product.id)
    @cart_product.update(quantity: params[:quantity])
    
    respond_to do |format|
      format.html { redirect_to cart_path(@cart) }
      format.js
    end
  end
end
