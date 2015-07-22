class OrdersController < ApplicationController
  before_action :require_login, except: [:edit, :update, :confirmation]

  #before_action :restrict_across_merchant, except: [:edit, :update, :confirmation]

  def index
    # a merchant can view all of their 'completed' orders
    # a merchant can view all of their 'paid' and 'shipped' orders
    if session[:merchant_id] == params[:merchant_id].to_i
      @merchant = Merchant.find(params[:merchant_id])
      # find only orders that are complete
      @orders = @merchant.orders.where(status: "complete").uniq.reverse
      @order_items = @orders.order_items.where(merchant_id: @merchant.id)

      # from completed orders, find order items that belong to this merchant
      # sum up the revenue from these order items
      @shipped_revenue = shipped_revenue(@orders)
      @unshipped_revenue = unshipped_revenue(@orders)


      count = 0
      @orders.each do |order|
        order.order_items.each do |order_item|
          if order_item == order
            count += 1
          end
        end
      end

    else
      flash[:error] = "You do not have access to that merchant's orders."

      redirect_to merchant_path(session[:merchant_id])
    end

    # @shipped_revenue = merchant.shipped?(true).sum("revenue")
    # @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    # @shipped_count = merchant.shipped?(true).count
    # @unshipped_count = merchant.shipped?(false).count
  end

  def shipped_revenue(orders)
    shipped_rev = 0
    orders.each do |order|
      relevant_items = order.order_items.where(merchant_id: @merchant.id)
      order_total = relevant_items.where(shipped: true).sum("revenue")
      shipped_rev += order_total
    end
    return shipped_rev
  end

  def unshipped_revenue(orders)
    unshipped_rev = 0
    orders.each do |order|
      relevant_items = order.order_items.where(merchant_id: @merchant.id)
      order_total = relevant_items.where(shipped: false).sum("revenue")
      unshipped_rev = order_total
    end
    return unshipped_rev
  end

  def shipped
    @merchant = Merchant.find(params[:merchant_id])
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = @merchant.order_items.where(shipped: true)

    # @shipped_revenue = merchant.shipped?(true).sum("revenue")
    # @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    # @shipped_count = merchant.shipped?(true).count
    # @unshipped_count = merchant.shipped?(false).count
  end

  def unshipped
    @merchant = Merchant.find(params[:merchant_id])
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = @merchant.order_items.where(shipped: false)

    # @shipped_revenue = merchant.shipped?(true).sum("revenue")
    # @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    # @shipped_count = merchant.shipped?(true).count
    # @unshipped_count = merchant.shipped?(false).count
  end

  def show
    # a merchant can view a particular order and all of its details (i.e. order_items/totals, etc.)
    @order = Order.find(params[:id])

    @order_items = Merchant.find(params[:merchant_id]).order_items

    @redacted_cc = redacted_cc(@order.credit_card)
  end

  def create
    # order gets created initially withOUT payment details (this happens at checkout)
  end

  def edit
    # every time a new order_item is added/removed from the cart
    # when the customer adds their payment details
    if session[:order_id] == params[:id]
      @order = Order.find(params[:id])
    else
      flash[:error] = "You do not have access to that order."

      redirect_to root_path
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.update(status: "complete")

    @order.order_items.each do |order_item|
      product = Product.find(order_item.product_id)
      previous_stock = product[:stock]
      ordered_stock = order_item.quantity

      new_stock = previous_stock.to_i - ordered_stock.to_i
      product.update(stock: new_stock)
    end

    session[:order_id] = nil # this clears the cart after you've checked out

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
