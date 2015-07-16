class SessionsController < ApplicationController

def new
end

def create
  @merchant = Merchant.find_by(email: params[:session][:email])
  if @merchant && @merchant.authenticate(params[:session][:password])
    session[:merchant_id] = @merchant.id
    redirect_to root_path
  else
    flash.now[:error] = "Try again, password incorrect."
    render :new
  end 
end

def destroy
  session[:merchant_id] = nil
  redirect_to root_path
end

end
