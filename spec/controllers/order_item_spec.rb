require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  # describe "DELETE #destroy" do
    
  #   it "deletes an order_item" do
  #     current_order = Order.new
  #     order_item = OrderItem.new(product_id: 2, revenue: 12.50, quantity: 1, order_id: current_order.id)

  #     puts order_item.valid?
  #     puts order_item.id

  #     delete :destroy, id: 

  #     expect(order_item).to_not be_valid
  #   end
  
  # end

  it "marks things as shipped" do
    order_item = OrderItem.find(5)
    merchant_id = order_item.merchant_id

    patch :mark_shipped, merchant_id: merchant_id, id: order_item.id

    order_item.reload
    
    expect(order_item.shipped).to eq true
  end


end
