RSpec.describe Review, type: :model do 

  describe "model validations" do
    it "requires content, rating, and product_id" do
      review = Review.new

      expect(review).to_not be_valid
      expect(review.errors.keys).to include(:content,:rating,:product_id)
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
