class UsersController < ApplicationController
  before_action :authenticate_user! && :restrict_to_user

  def show
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  private
  def restrict_to_user
    if current_user.id != params[:id].to_i
      flash[:alert] = "L'accès à cette page ne vous est pas autorisé"
      redirect_to root_path
    end
  end

end
