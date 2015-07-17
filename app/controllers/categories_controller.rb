class CategoriesController < ApplicationController
  def index
    # need this for shopping for items by category
  end

  def new
    @categories = Category.all.order(:name)
    @category = Category.new
  end

  def create
    @category = Category.create(create_params[:category])

    redirect_to :back
  end


  # def edit
  #
  # end
  #
  # def show
  #
  # end
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
