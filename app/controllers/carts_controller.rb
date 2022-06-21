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
      @products = @cart.cart_products.order(:created_at)
    else
      @cart = Cart.new(user_id: current_user.id)
      @cart.save!
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
