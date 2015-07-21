class MerchantsController < ApplicationController
  def index

  end

  def show
    @merchant = Merchant.find(params[:id])

    @merchant_products = @merchant.products
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.create(merchant_params)

    redirect_to root_path
  end

  def edit

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

#________________________________________________________________________________
  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :password, :password_confirmation)
  end


end
