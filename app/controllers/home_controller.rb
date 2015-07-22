class HomeController < ApplicationController

  def index
    @product_first_row = Product.first(3)
    @product_second_row = Product.last(3)
  end

end
