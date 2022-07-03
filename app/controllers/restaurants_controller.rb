class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.order(:zipcode)
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
