class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_products
  has_many :products, through: :order_products

  enum order_type: [:withdrawal, :delivery]
  enum order_status: [:registered, :in_progress, :completed, :withdrawn, :delivered]
  # Not used:  Will be pulled from Stripe
  # enum paiement_status: { canceled: 0, paid: 1 }

  validates :reference, presence: true,
    length: { minimum: 5, maximum: 255 },
    format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :total, presence: true,
    length: { minimum: 1, maximum: 7 },
    numericality: { greater_or_equal_to: 0, less_or_equal_to: 99999.99 },
    format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
end