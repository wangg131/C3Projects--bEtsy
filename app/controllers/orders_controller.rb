class OrdersController < ApplicationController
  before_action :require_login, except: [:edit, :update, :confirmation]

  #before_action :restrict_across_merchant, except: [:edit, :update, :confirmation]

  def index

    # a merchant can view all of their 'completed' orders
    # a merchant can view all of their 'paid' and 'shipped' orders
    @merchant = Merchant.find(params[:merchant_id])
    # find only orders that are complete
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = @merchant.order_items

    if session[:merchant_id] == params[:merchant_id].to_i
      @merchant = Merchant.find(params[:merchant_id])

      # find only orders that are complete
      @orders = @merchant.orders.where(status: "complete").uniq.reverse

      @order_items = find_relevant_order_items(@orders, @merchant.id)

      # from completed orders, find order items that belong to this merchant
      # sum up the revenue from these order items
      @shipped_revenue = revenue(@order_items)
      @unshipped_revenue = revenue(@order_items)
      @shipped_count = count_items(@order_items, true)
      @unshipped_count = count_items(@order_items, false)

    else
      flash[:error] = "You do not have access to that merchant's orders."

      redirect_to merchant_dashboard_path(session[:merchant_id])
    end


  end

  def shipped

    merchant = Merchant.find(params[:merchant_id])
    @order_items = merchant.order_items.where(shipped: true)
    @orders = merchant.orders.uniq.reverse

    @shipped_revenue = merchant.shipped?(true).sum("revenue")
    @unshipped_revenue = merchant.shipped?(false).sum("revenue")
    @shipped_count = merchant.shipped?(true).count
    @unshipped_count = merchant.shipped?(false).count

    @merchant = Merchant.find(params[:merchant_id])
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = find_relevant_order_items(@orders, @merchant.id)
    @order_items_shipped = shipped?(@order_items, true)
    @shipped_orders = find_orders_by_status(@orders, true, @merchant.id)

    @shipped_revenue = revenue(@order_items)
    @unshipped_revenue = revenue(@order_items)
    @shipped_count = count_items(@order_items, true)
    @unshipped_count = count_items(@order_items, false)

  end

  def unshipped
    @merchant = Merchant.find(params[:merchant_id])
    @orders = @merchant.orders.where(status: "complete").uniq.reverse
    @order_items = find_relevant_order_items(@orders, @merchant.id)
    @order_items_unshipped = shipped?(@order_items, false)

    @unshipped_orders = find_orders_by_status(@orders, false, @merchant.id)


    @shipped_revenue = revenue(@order_items)
    @unshipped_revenue = revenue(@order_items)
    @shipped_count = count_items(@order_items, true)
    @unshipped_count = count_items(@order_items, false)
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

  def shipped?(order_items, bool)
    final_items = []
    order_items.each do |order_item|
      if order_item.shipped == bool
        final_items.push(order_item)
      end
    end
    return final_items
  end

  def count_items(order_items, bool)
    count = 0
    order_items.each do |order_item|
      if order_item.shipped == bool
        count += order_item.quantity
      end
    end
    return count
  end

  def find_relevant_order_items(orders, merchant_id)
    relevant_order_items = []
    orders.each do |order|
      all_order_items = order.order_items
      order_items = all_order_items.where(merchant_id: merchant_id)
      relevant_order_items.push(order_items)
    end
    return relevant_order_items.flatten
  end

  def find_orders_by_status(orders, bool, merchant_id)
    relevant_orders = []
    orders.each do |order|
      # order_items include order_items that don't belong to the merchant
      all_order_items = find_relevant_order_items([order], merchant_id)
      all_order_items.each do |order_item|
        if order_item.shipped == bool
          relevant_orders.push(order_item.order)
        end
      end
    end
    return relevant_orders.uniq
  end


  def revenue(order_items)
    revenue = 0
    order_items.each do |order_item|
        revenue += order_item.revenue
    end
    return revenue
  end

  private

  def order_params
  params.require(:order).permit(:status, :name, :email, :street, :city, :state, :zip, :credit_card, :exp_date, :cvv, :billing_zip)
  end

  def redacted_cc(credit_card)
    credit_card.chars.last(4).join
  end
end
