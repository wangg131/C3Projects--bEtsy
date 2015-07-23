require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe "model validations" do
    it "requires a name, email, and password and password_confirmation all the time" do
      merchant = Merchant.new

      expect(merchant).to_not be_valid
      expect(merchant.errors.keys).to include(:name,:email,:password,:password_confirmation)
    end
  end

end
