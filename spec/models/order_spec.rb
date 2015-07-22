require 'rails_helper'

RSpec.describe Order, type: :model do 

  describe "model validations" do
    it "requires a name all the time" do
      order = Order.new

      expect(order).to_not be_valid
      expect(order.errors.keys).to include(:name)
    end
  end

end
