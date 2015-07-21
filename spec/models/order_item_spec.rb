require 'rails_helper'

RSpec.describe OrderItem, type: :model do 

  describe "model validations" do
    it "requires a product_id, order_id, revenue, and shipped all the time" do
      order_item = Order_Item.new

      expect(order_item).to_not be_valid
      expect(order_item.errors.keys).to include(:product_id, :order_id, :revenue, :shipped)
    end
  end

  # describe "best scope" do
  #   it "ranks all the albums by vote in descending order" do
  #     album1= Album.create(name:'a', artist:'b', description: 'c', vote:30)
  #     album2= Album.create(name:'a', artist:'b', description: 'c', vote:3)
  #     album3= Album.create(name:'a', artist:'b', description: 'c', vote:20)

  #     right_rank = [album1, album3, album2]

  #     expect(Album.best(3)).to eq right_rank
  #   end
  # end
end
