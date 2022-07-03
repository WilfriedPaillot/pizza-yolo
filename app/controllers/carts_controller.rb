class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def new
    @cart = Cart.new(user_id: params[:id])
  end

  def create
    if current_user.cart == nil
      @cart = Cart.new(cart_params)
      @cart.user_id = current_user.id
      @cart.save
    else
      @cart = current_user.cart
    end
  end

  def show
    if current_user.cart != nil
      @cart = current_user.cart
      # @products = @cart.cart_products.order(:created_at)
      # @products = @cart.cart_products.order(:created_at).map(&:product)
      #@cart_products = @cart.cart_products.includes(:product).group_by { |cp| cp.product.category } 
      @cart_products = @cart.cart_products.includes(:product).group_by { |cp| cp.product.category }.sort_by { |category, products| category.id }
      @cart_products.each do |category, products|
        products.sort_by! { |cp| cp.product.name }
      end
    else
      @cart = Cart.new(user_id: current_user.id)
      @cart.save!
    end
  end

  def destroy
    @cart = current_user.cart # Added after bug 03072022
    @cart.cart_products.destroy_all
    respond_to do |format|
      format.html { redirect_to @cart, notice: 'Cart was successfully destroyed.' }
      format.js {}
    end
  end

  private
  def set_cart
    @cart = Cart.find_by(user_id: params[:id])
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end

end
