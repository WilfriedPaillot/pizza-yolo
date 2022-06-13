class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.order(:price)
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
