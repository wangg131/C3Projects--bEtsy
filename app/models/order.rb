class Order < ActiveRecord::Base
  # Scopes 

  # Validations 
  # can't validate any fields bc you don't 
  # enter that info until the last step 

  # Associations
  has_many :order_items
  has_many :products, :through => :order_items
end
