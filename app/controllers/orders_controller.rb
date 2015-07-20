class OrdersController < ApplicationController

  def index
    # a merchant can view all of their 'paid' and 'shipped' orders
    @order_items = Merchant.find(params[:merchant_id]).order_items

    @orders = get_orders(@order_items)

    @shipped_revenue = 0
    @unshipped_revenue = 0
    @shipped_count = 0
    @unshipped_count = 0

    @order_items.each do |order_item|
      if order_item.shipped == true
        @shipped_revenue += order_item.revenue
        @shipped_count += 1
      else
        @unshipped_revenue += order_item.revenue
        @unshipped_count += 1
      end
    end

  end

  def show
    # a merchant can view a particular order and all of its details (i.e. order_items/totals, etc.)
    @order = Order.find(params[:id])

    @order_items = Merchant.find(params[:merchant_id]).order_items

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

  private

  def get_orders(order_items)
    orders = []

    order_items.each do |order_item|
      orders.push(order_item.order)
    end

    return orders.uniq
  end



end
