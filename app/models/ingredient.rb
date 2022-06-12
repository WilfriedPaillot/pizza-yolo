class Ingredient < ApplicationRecord
  belongs_to :unit
  has_many :product_ingredients
  has_many :products, through: :product_ingredients

  validates :name, presence: true,
    length: { minimum: 3, maximum: 50 },
    format: { with: /\A[a-zA-Z\s'-]+\z/ }
end
