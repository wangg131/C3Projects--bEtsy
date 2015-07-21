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

    @redacted_cc = redacted_cc(@order.credit_card)
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
    @order = Order.find(params[:id])
  end

  def update
    # when the customer enters their payment info,
    # it updates the order record, making it "complete"
    # order.status == 'paid' when they have entered their payment info
    @order = Order.find(params[:id])

    @order.update(order_params)

    @order.update(status: "complete")

    redirect_to order_confirmation_path(params[:id])
  end


  def destroy
    # if the customer 'clears' their cart ??? (need button for this)
  end

  def confirmation
    @order = Order.find(params[:order_id])

    @order_items = @order.order_items

    @total = get_total(@order_items)

    @customer_info = get_customer_info(@order)
  end

  def shipped
    @order_items = Merchant.find(params[:merchant_id]).order_items.where(shipped: true)

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

  def unshipped
    @order_items = Merchant.find(params[:merchant_id]).order_items.where(shipped: false)

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

  def get_total(order_items)
    order_items.inject(0) do |sum, i|
      sum + i.revenue
    end
  end

  def get_customer_info(order)
    customer_info = []

    customer_info.push(order.name, order.email, order.street, order.city, order.state, order.zip)
  end

  private

  def order_params
  params.require(:order).permit(:status, :name, :email, :street, :city, :state, :zip, :credit_card, :exp_date, :cvv, :billing_zip)
  end

  def get_orders(order_items)

    orders = []

    order_items.each do |order_item|
      orders.push(order_item.order)
    end

    return orders.uniq
  end

  def redacted_cc(credit_card)
    credit_card.chars.last(4).join
  end
end
