class CategoriesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    # need this for shopping for items by category
    @categories = Category.all
    @products = Product.all
  end

  def new
    @categories = Category.all.order(:name)
    @category = Category.new
  end

  def create
    @category = Category.create(create_params[:category])

    redirect_to :back
  end

  def show

 
    @products = Category.find(params[:id]).products.where(active: true) 

    @category = Category.find(params[:id])
    # @products = @category.products 

  end


  # def edit
  #
  # end
  #

  #
  # def update
  #
  # end
  #
  # def destroy
  #
  # end
  private

  def create_params
    params.permit(category: [:name])
  end
end
