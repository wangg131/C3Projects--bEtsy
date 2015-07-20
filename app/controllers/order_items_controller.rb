class OrderItemsController < ApplicationController

  # Not sure if what is in the cart is an index of order_items or an index of the order?

  def index
    # a customer can see all of their order_items in an order that is 'pending'? (i.e. the cart)
  end

  # def show
    # Do we need this??? If a customer clicks on an order_item,
    # I think that it will actually take them to the products#show page
  # end

  def new
    # when a customer adds a product to the 'cart' (i.e. adds a new order_item to the order)
    # when a customer increases the qty number for a product in the cart view (i.e. 2 > 3 sweaters)

    # calls the 'check_stock' method to see if it can make a new one
  end

  def create
    # writes the creation of the new order_item to the db
  end

  def edit
    # a merchant can mark an order item as 'shipped == true' when they've shipped it
  end

  def update
    # writes the edits of the order_item to the db
  end

  def destroy
    # if a customer decreases the qty number for a product in the cart view (i.e. 3 > 1 sweater)
    # if a customer clicks an 'x' in the cart view to remove all units of that product??
  end

  def check_stock
    # when you create a new order_item, it needs to check that the stock for
    # that product is >= the total number of order_items that you want
  end

  def mark_shipped
    order_item = OrderItem.find(params[:id])
    order_item.update(shipped: true)

    redirect_to(:back)
  end
  
  private


end
