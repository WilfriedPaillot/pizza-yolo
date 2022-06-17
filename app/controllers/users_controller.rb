class UsersController < ApplicationController
  before_action :authenticate_user! && :restrict_to_user
  after_create :send_welcome_email

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

  def send_welcome_email
    UserMailer.welcome_email(@user).deliver_now
  end

end
