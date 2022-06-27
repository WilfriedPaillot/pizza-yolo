class StaticPagesController < ApplicationController
  def homepage
    # products = OrderProduct.group(:product_id).sum(:quantity)
    #   p "*" * 100
    #   p "products: #{products}"
    #   p "*" * 100
    # products.each do |product|
    #   p "*" * 100
    #   p "Product: #{Product.find(product[0]).name} - Quantity: #{product[1]}"
    #   p "*" * 100
    # end
    # @best_sellers = products.sort_by { |k, v| v }.reverse.take(3).map { |p| Product.find(p[0]) }
    @best_sellers = OrderProduct.group(:product_id).sum(:quantity).sort_by { |k, v| v }.reverse.take(3).map { |k, v| Product.find(k) }
  end
end
