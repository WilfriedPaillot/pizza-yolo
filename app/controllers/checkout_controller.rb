class CheckoutController < ApplicationController
  before_action :profil_completed, only: [:create]

  def new
  end

  def create
    @products = current_user.cart.cart_products

    line_items = []
    @products.each do |product|
      line_items.push({
        name: product.product.name,
        quantity: product.quantity,
        amount: (product.product.price * 100).to_i,
        currency: "eur",
      })
    end

    target = current_user.orders.map(&:total).sum.to_i 
    case target > 0
      when target > 100 && target < 250
        @coupon = "10"
      when target > 250 && target < 500
        @coupon = "15"
      when target > 500
        @coupon = "20"
      else
        @coupon = nil
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      discounts: [{
        coupon: @coupon
      }],
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url
    )
    respond_to do |format|
      format.json { render json: @session }
      format.js {}
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    @order = Order.create!(
      user_id: current_user.id,
      total: @payment.amount / 100,
      reference: @payment.created
    )

    @cart = current_user.cart
    @cart.cart_products.each do |cart_product|
      cart_product.destroy!
    end

    redirect_to root_path, notice: "Payment successful"
  end

  def cancel
    puts "Payment canceled"
  end

  def profil_completed
    current_user.attributes.each do |key, value|
      unless key = "reset_password_token"
        if value.nil?
          redirect_to edit_user_registration_path(current_user.id), notice: "Please complete your profile"  and return
        end
      end
    end
  end
  
end
