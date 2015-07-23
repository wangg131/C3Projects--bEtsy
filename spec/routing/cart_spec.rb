require 'rails_helper'

RSpec.describe "routes for Carts", type: :routing do

  it "routes /cart to the carts controller" do
    expect(get("/cart")).to route_to("carts#show")
  end

  it "route /add_to_cart is routable" do
    expect(post("/add_to_cart/1")).to be_routable
  end
end
