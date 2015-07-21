class CartsController < ApplicationController

  def new_order
    @order = Order.create
    params[:order_id] = @order.id
  end

  def add_to_cart
    new_order if OrderItem.count == 0 
    # if it's the first item being added to the cart, need to generate 
    # the new order to associate with it first

    product = Product.find(params[:id])

    params[:product_id] = product.id
    @order_item = OrderItem.create(product_id: params[:product_id], order_id: params[:order_id])

    # @order.products << @order_item
    redirect_to :back
  end

  def show
    order = Order.find(1)
    @order_products = order.products
  end

#________________________________________________________________________________
  private

  # def order_item_params
  #   params.require(:order_item).permit(:product_id, :order_id, :revenue, :shipped, :merchant_id)
  # end

end
