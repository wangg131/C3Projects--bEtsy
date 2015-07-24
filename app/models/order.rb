class Order < ActiveRecord::Base
  # Associations
  has_many :order_items
  has_many :products, :through => :order_items
end
