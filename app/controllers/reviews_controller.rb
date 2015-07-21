class ReviewsController < ApplicationController
  def index

  end

  def create

    @review = Review.create(review_params)


    redirect_to :back
  end

  def new
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @review = Review.new
    

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end
#________________________________________________________________________________
  private

  def review_params
    params.require(:review).permit(:content, :rating, :product_id)
  end
 
 def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :active, :photo_url, :merchant_id, :category_id)
 end

end
