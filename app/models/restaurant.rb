class Restaurant < ApplicationRecord
  has_many :products
  has_many :comments, dependent: :destroy
  belongs_to :user
end
