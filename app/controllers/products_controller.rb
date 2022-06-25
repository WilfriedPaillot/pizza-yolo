class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id].present?
      @products = Product.where(category_id: params[:category_id]).includes(:category).group_by { |p| p.category }.map { |k, v| [k, v.sort_by(&:name)] }
    else
      @products = Product.includes(:category).group_by { |p| p.category }.sort_by { |category, products| category.id }
      @products.each do |category, products|
        products.sort_by! { |p| p.name }
      end
    end
    respond_to do |format|
      format.html { render :index }
      format.js {}
    end
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end
