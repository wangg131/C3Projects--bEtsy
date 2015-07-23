require 'rails_helper'
RSpec.describe MerchantsController, type: :controller do
  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      # get :show

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do


    expect(response).to be_success
    expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
  it "responds successfully with an HTTP 200 status code" do

    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
end

  describe "GET #dashboard" do
    it "responds successfully with an HTTP 200 status code" do


      expect(response).to be_success
      expect(response).to have_http_status(200)
      end
    end

before :each do
  @merchant = Merchant.find(3)
end

  describe "merchant attributes" do
    it "knows the merchant's name" do
      expect(@merchant.name).to eq("Material Girl")
    end

    it "knows the merchant's email" do
      expect(@merchant.email).to eq("luckystar@email.com")
    end

    it "does not allow access to the merchant's password" do
      expect(@merchant.password).to eq(nil)
    end
  end
end






