class RestaurantEmployee < ApplicationRecord
  belongs_to :restaurant
  belongs_to :employee, class_name: 'User'
end
