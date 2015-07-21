require 'rails_helper'

# RSpec.describe SessionsController, type: :controller do
 
#   it "displays the user's username after successful login" do
#     session = Session.create!(:username => "jdoe", :password => "secret")
#     get "/login"
#     assert_select "form.login" do
#       assert_select "input[name=?]", "username"
#       assert_select "input[name=?]", "password"
#       assert_select "input[type=?]", "submit"
#     end

#     post "/login", :username => "jdoe", :password => "secret"
#     assert_select ".header .username", :text => "jdoe"
#   end
# end

# def create
#   @merchant = Merchant.find_by(email: params[:session][:email])
#   if @merchant && @merchant.authenticate(params[:session][:password])
#     session[:merchant_id] = @merchant.id
#     redirect_to root_path
#   else
#     flash.now[:error] = "Try again, password incorrect."
#     render :new
#   end 
# end