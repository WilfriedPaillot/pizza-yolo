class CartProduct < ApplicationRecord
  before_create :set_default_quantity, :if => :new_record?

  belongs_to :cart
  belongs_to :product

  def set_default_quantity
    self.quantity ||= 1
  end

  def subtotal_price
    self.product.price * self.quantity
  end
end
