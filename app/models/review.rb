class Review < ActiveRecord::Base
  # Scopes 
  
  # Validations 
  validates :content, presence: true
  validates :rating, presence: true
  validates :product_id, presence: true

  # Associations
  belongs_to :product
end
