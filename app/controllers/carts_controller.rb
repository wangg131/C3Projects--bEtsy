class CartsController < ApplicationController

  def first_cart_item
    # the first time an item is added to the cart,
      # 1. a new order is created
      # 2. a new order_item(s) is/are created too
  end

end
