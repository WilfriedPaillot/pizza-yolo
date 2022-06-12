class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true,
    length: { minimum: 3, maximum: 50 },
    format: { with: /\A[a-zA-Z\s'-]+\z/ }
  validates :description, presence: true,
    length: { minimum: 3, maximum: 150 }
end
