class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products
  has_many :products, through: :cart_products

  
  def total_price
    total = 0
    self.cart_products.each do |cart_product|
      total += cart_product.product.price * cart_product.quantity
    end
    total
  end

end
