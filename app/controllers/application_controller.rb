class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_categories, :set_login_name

   def set_categories
     @categories = Category.all.order(:name)
   end

   def set_login_name
     @merchant = Merchant.find_by(id: session[:merchant_id])
     @merchant_name = @merchant ? @merchant.name : "Guest"
   end

  def require_login
    unless session[:merchant_id]

      flash[:error] = "You must be logged in to perform that action"

      redirect_to login_path
    end
  end

  helper_method :current_order
  helper_method :cart_units

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.create(status: "pending")
    end
  end

  def cart_units
    cart_units = 0

    current_order.order_items.each do |order_item|
      cart_units += order_item.quantity
    end

    return cart_units
  end
end

