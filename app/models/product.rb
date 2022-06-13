class Product < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :product_ingredients
  has_many :ingredients, through: :product_ingredients

  validates :name, presence: true,
    length: { minimum: 3, maximum: 50 },
    format: { with: /\A[a-zA-Z\s'-]+\z/ },
    uniqueness: { case_sensitive: false }
  validates :description, presence: true,
    length: { minimum: 3, maximum: 150 }
  validates :price, presence: true,
    length: { minimum: 1, maximum: 5 },
    format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  validates :image_url, presence: true,
    length: { maximum: 255 },
    format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix }

scope :featured, -> (limit) { limit(limit).order(:name) }
end
