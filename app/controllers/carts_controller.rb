class CartsController < ApplicationController

  def show
    # @order_products = current_order.products
    @order_items = current_order.order_items

    # raise
  end

  def add_to_cart
    product = Product.find(params[:id])

    params[:product_id] = product.id
    @order_item = OrderItem.create(
      product_id: params[:product_id], 
      order_id: params[:order_id], 
      shipped: false,
      quantity: 1)

    raise
    # @order.products << @order_item
    redirect_to '/cart'
  end


#________________________________________________________________________________
  private


end
