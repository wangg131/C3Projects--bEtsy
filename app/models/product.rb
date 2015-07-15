class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :categories
  has_many :order_items
  has_many :reviews
  
end
