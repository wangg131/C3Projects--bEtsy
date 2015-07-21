class OrderItem < ActiveRecord::Base
  # Validations
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :revenue, presence: true
  validates :quantity, presence: true

  # Associations
  belongs_to :order
  belongs_to :product
  belongs_to :merchant

  before_save :finalize

  def unit_price
    if persisted?
      self[:revenue]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  # Scopes
  
  private

    def product_present
      if product.active? == false
        errors.add(:product, "Sorry, this product is no longer available.")
      end
    end

    def finalize
      self[:revenue] = total_price
    end



end
