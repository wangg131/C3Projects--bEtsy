class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :order_items
  has_many :reviews
  has_and_belongs_to_many :categories




# Model Methods ______________

end
