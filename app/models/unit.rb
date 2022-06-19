class Unit < ApplicationRecord
  has_many :ingredients

  validates :name, presence: true,
    length: { minimum: 3, maximum: 25 },
    format: { with: /\A[a-zA-Z\s'-éàèêçù]+\z/ }
  validates :tag, presence: true,
    length: { minimum: 1, maximum: 3 },
    format: { with: /\A[a-zA-Z\s'-éàèêçù]+\z/ }
end
