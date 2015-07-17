class Product < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :category
  has_many :order_items
  has_many :reviews

end
