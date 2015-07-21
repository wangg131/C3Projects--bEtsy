class OrderItem < ActiveRecord::Base
  # Scopes

  # Validations
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :revenue, presence: true
  validates :quantity, presence: true

  # Associations
  belongs_to :order
  belongs_to :product
  belongs_to :merchant

  # before_save :finalize

  # def total_price
  #   @order_item = OrderItem.find(params[:order_id])
  #   @order_item.revenue * @order_item.quantity
  # end


#############################################################
  private

    # def product_present
    #   if product.active? == false
    #     errors.add(:product, "Sorry, this product is no longer available.")
    #   end
    # end

    # def finalize
    #   self[:revenue] = total_price
    # end
end
