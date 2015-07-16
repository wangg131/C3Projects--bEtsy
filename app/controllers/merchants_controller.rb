class MerchantsController < ApplicationController
  def index

  end

  def create

  end

  def new

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  def dashboard
    # may change the params depending on sessions
    @merchant = Merchant.find(params[:merchant_id])

    @products = @merchant.products

    # @total_revenue = @products.order_item.revenue
  end
end
