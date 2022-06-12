class Ingredient < ApplicationRecord
  belongs_to :unit
  has_many :product_ingredients
  has_many :products, through: :product_ingredients
end
