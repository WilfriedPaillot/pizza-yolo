class UsersController < ApplicationController
  before_action :authenticate_user! && :restrict_to_user

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.order(created_at: :desc).limit(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_columns(restaurant_id: user_params[:restaurant_id])
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Votre profil a été mis à jour.' }
        format.js { }
      end
    else
      respond_to do |format|
        format.html { render :edit, notice: 'Votre profil n\'a pas pu être mis à jour.' }
      end
    end
  end

  private
  def restrict_to_user
    if current_user.id != params[:id].to_i
      flash[:alert] = "L'accès à cette page ne vous est pas autorisé"
      redirect_to root_path
    end
  end

  def user_params
    # params.require(:user).permit(:firstname, :lastname, :address, :city, :phone, :zipcode, :restaurant_id)
    params.require(:user).permit(:restaurant_id)
  end
end
