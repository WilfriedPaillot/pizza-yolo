class Product < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :product_ingredients
  has_many :ingredients, through: :product_ingredients
end
