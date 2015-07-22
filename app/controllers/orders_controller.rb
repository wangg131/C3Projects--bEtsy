class OrdersController < ApplicationController
  before_action :require_login, except: [:edit, :update, :confirmation]

  def index
    # a merchant can view all of their 'paid' and 'shipped' orders
    @merchant = Merchant.find(params[:merchant_id])
    # find only orders that are complete
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = @merchant.order_items

    # @shipped_revenue = merchant.shipped?(true).sum("revenue")
    # @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    # @shipped_count = merchant.shipped?(true).count
    # @unshipped_count = merchant.shipped?(false).count
  end

  def shipped
    merchant = Merchant.find(params[:merchant_id])
    @order_items = merchant.order_items.where(shipped: true)
    @orders = merchant.orders.uniq.reverse

    @shipped_revenue = merchant.shipped?(true).sum("revenue")
    @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    @shipped_count = merchant.shipped?(true).count
    @unshipped_count = merchant.shipped?(false).count
  end

  def unshipped
    merchant = Merchant.find(params[:merchant_id])
    @order_items = merchant.order_items.where(shipped: false)
    @orders = merchant.orders.uniq.reverse

    @shipped_revenue = merchant.shipped?(true).sum("revenue")
    @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    @shipped_count = merchant.shipped?(true).count
    @unshipped_count = merchant.shipped?(false).count
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

    session[:order_id] = nil

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

  def redacted_cc(credit_card)
    credit_card.chars.last(4).join
  end
end
