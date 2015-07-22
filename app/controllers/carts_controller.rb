class CartsController < ApplicationController

  def show
    @order_items = current_order.order_items

    calc_unit_total
    calc_order_total 
  end

  def calc_unit_total
    @unit_total = 0

    @order_items.each do |order_item|
      @unit_total += order_item.quantity
    end

    return @unit_total
  end

  def calc_order_total 
    @order_total = 0

    @order_items.each do |order_item|
      @order_total += order_item.revenue
    end
    
    return @order_total
  end

end
