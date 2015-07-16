class MerchantsController < ApplicationController
  def index

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

  def show

  end

  def update

  end

  def destroy

  end

#________________________________________________________________________________
  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :password, :password_confirmation)
  end



end
