class OrderItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :orders, :through => :cart
  belongs_to :product
end
