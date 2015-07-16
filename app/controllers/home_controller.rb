class HomeController < ApplicationController

  def index
    @merchant = Merchant.find_by(id: session[:merchant_id])
    @merchant_name = @merchant ? @merchant.name : "Guest"
  end

end
