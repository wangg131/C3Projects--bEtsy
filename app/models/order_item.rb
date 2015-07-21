class OrderItem < ActiveRecord::Base
  # Validations
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :revenue, presence: true


  # Associations
  belongs_to :order
  belongs_to :product
  belongs_to :merchant

  # Scopes

end
