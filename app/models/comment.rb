class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates :quote, presence: true,
    length: { in: 1..5 },
    numericality: { only_integer: true, greater_than: 0, less_or_equal_to: 5 }
  validates :message, presence: true,
    length: { minimum: 3, maximum: 160 }
end
