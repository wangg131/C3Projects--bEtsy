require 'rails_helper'

RSpec.describe OrderItem, type: :model do 

  describe "model validations" do
    it "requires a product_id, order_id, revenue, and quantity all the time" do
      order_item = OrderItem.new

      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include(:product_id, :order_id, :revenue, :quantity)
    end
  end

end
