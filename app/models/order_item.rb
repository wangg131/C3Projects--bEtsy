class OrderItem < ActiveRecord::Base
  # Scopes 
  
  # Validations 
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :revenue, presence: true
  validates :shipped, presence: true

  # Associations 
  belongs_to :order
  belongs_to :product
  belongs_to :merchant
end
