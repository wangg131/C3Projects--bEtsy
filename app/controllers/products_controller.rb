class ProductsController < ApplicationController

  def index
    # a guest or merchant can view all products with their details

    # a guest or merchant can view all products by category
  end

  def show
    # product detail page
    # some conditional visuals based on if you're logged in or not (view-things)
      # merchants can't buy their own products (i.e. no 'add to cart' button for them)
      # merchants can't leave reviews for their own products
      # if instock? == false, you can't add it to the cart
  end

  def new
    # a merchant can create a new product using a form
    # (nested routing bc the prod is associated with that merchant only)
    # takes you to a form page
    @product = Product.new
  end

  def create
    # submits the form to save the new product to the db
    # redirects you to the merchant dashboard page
    @product = Product.create(create_params[:product])

    redirect_to merchant_dashboard_path(params[:merchant_id])
  end

  def edit
    # a merchant can edit details about a product using a form
    # note: changing the price of a product will NOT change the price of the order_item (intentionally)
    # takes you to a form page
    @product = Product.find(params[:id])
  end

  def update
    # submits the form to save changes to the product details
    # redirects you to the merchant dashboard page
    @product = Product.find(params[:id])

    @product.update(create_params[:product])

    redirect_to merchant_dashboard_path(params[:merchant_id])
  end

  def destroy
    # a merchant can delete a product from their dashboard page by clicking the 'x' next to the product
    # does it right on the same screen, doesn't take you somewhere else to do it
    # redirects you to the merchant dashboard page when done
    @product = Product.find(params[:id])

    @product.destroy

    redirect_to(:back)
  end

  def active_update
   @product = Product.find(params[:id])

    if @product.active == true
      @product.update(active: false)
    else
      @product.update(active: true)
    end

    redirect_to(:back)
  end

  def instock?
    # checks to see if product.stock > 0
      # if true, then it's ok to purchase
      # if false, then the product is 'out of stock' and cannot be purchased
  end

  private

  def create_params
    params.permit(product: [:name, :description, :price, :stock, :active, :photo_url, :merchant_id])

  end

end
