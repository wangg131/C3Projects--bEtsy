class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :merchant
  has_one :payment 
  has_many :order_items, :through  => :cart
end
