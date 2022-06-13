class StaticPagesController < ApplicationController
  def homepage
    @products = Product.featured(3)
  end
end
