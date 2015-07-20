class Order < ActiveRecord::Base
  # Scopes 

  # Validations 
  validates :name, presence: true
  # can't validate the other info fields bc you don't 
  # enter that info until the last step 

  # Associations
  has_many :order_items
end
