class OrdersController < ApplicationController

  def index
    # a merchant can view all of their 'paid' and 'shipped' orders
    @order_items = Merchant.find(params[:merchant_id]).order_items


  end

  def show
    # a merchant can view a particular order and all of its details (i.e. order_items/totals, etc.)

    # CAN WE DO BOTH OF THESE?

    # the cart displays any 'pending' orders that exist ??
  end

  # def new
    # do we need this??? it might be taken care of by the 'cart' method
    # occurs the first time an item is added to the 'cart'
  # end

  def create
    # order gets created initially withOUT payment details (this happens at checkout)
  end

  def edit
    # every time a new order_item is added/removed from the cart
    # when the customer adds their payment details
  end

  def update
    # when the customer enters their payment info,
    # it updates the order record, making it "complete"
    # order.status == 'paid' when they have entered their payment info
  end

  def destroy
    # if the customer 'clears' their cart ??? (need button for this)
  end

end
