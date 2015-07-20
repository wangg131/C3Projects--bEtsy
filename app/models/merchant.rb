class Merchant < ActiveRecord::Base
  # Scopes

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /@/}
  validates :password, presence: true
  validates :password_confirmation, presence: true

  # Associations
  has_secure_password

  has_many :products
  has_many :orders

end
