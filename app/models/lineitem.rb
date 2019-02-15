class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates_numericality_of :total, :quantity, greater_than: 0
  def seller
    product.user.name
  end
end
