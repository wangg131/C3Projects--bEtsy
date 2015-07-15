class Cart < ActiveRecord::Base
  has_many :order_items
  has_many :orders
end
